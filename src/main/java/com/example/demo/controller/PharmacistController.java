package com.example.demo.controller;

import com.example.demo.model.Medicine;
import com.example.demo.model.Patient;
import com.example.demo.service.PharmacistService;
import com.example.demo.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/pharmacist")
public class PharmacistController {

    private final PharmacistService service;
    private final PatientService patientService;

    @Autowired
    public PharmacistController(PharmacistService service, PatientService patientService) {
        this.service = service;
        this.patientService = patientService;
    }

    @GetMapping("/new-prescription")
    public String newPrescription(@RequestParam(required = false) String medicineQuery,
                                  @RequestParam(required = false) String patientQuery,
                                  Model model) {

        // Search medicines if query provided
        List<Medicine> medicines = List.of();
        if (medicineQuery != null && !medicineQuery.trim().isEmpty()) {
            medicines = service.searchMedicines(medicineQuery.trim());
            model.addAttribute("medicineQuery", medicineQuery.trim());
            System.out.println("Medicine search for '" + medicineQuery.trim() + "' returned " + medicines.size() + " results");
        }

        // Search patients if query provided
        List<Patient> patients = List.of();
        if (patientQuery != null && !patientQuery.trim().isEmpty()) {
            patients = patientService.searchPatientsByNameOrPhone(patientQuery.trim());
            model.addAttribute("patientQuery", patientQuery.trim());
            System.out.println("Patient search for '" + patientQuery.trim() + "' returned " + patients.size() + " results");
        }

        model.addAttribute("allMeds", medicines);
        model.addAttribute("patients", patients);
        model.addAttribute("medicineQuery", medicineQuery != null ? medicineQuery.trim() : "");
        model.addAttribute("patientQuery", patientQuery != null ? patientQuery.trim() : "");

        // Recent patients to show under search
        try {
            List<Patient> recentPatients = patientService.getRecentPatients(8);
            model.addAttribute("recentPatients", recentPatients);
        } catch (Exception ignored) {}

        return "new-prescription";
    }

    @PostMapping("/new-prescription")
    public String createPrescription(@RequestParam(required = false) String name,
                                     @RequestParam(required = false) Integer age,
                                     @RequestParam(required = false) String phoneNumber,
                                     @RequestParam(required = false) String selectedPatientId,
                                     @RequestParam(required = false) List<Long> medicineIds,
                                     @RequestParam(required = false) List<Integer> qty,
                                     RedirectAttributes ra) {
        try {
            System.out.println("=== CREATE PRESCRIPTION DEBUG ===");
            System.out.println("Name: " + name);
            System.out.println("Age: " + age);
            System.out.println("Phone: " + phoneNumber);
            System.out.println("Selected Patient ID: " + selectedPatientId);
            System.out.println("Medicine IDs: " + medicineIds);
            System.out.println("Quantities: " + qty);

            // Validation
            if ((selectedPatientId == null || selectedPatientId.trim().isEmpty()) &&
                    (name == null || name.trim().isEmpty())) {
                ra.addFlashAttribute("error", "Please select an existing patient or provide a name for a new patient");
                return "redirect:/pharmacist/new-prescription";
            }

            if (medicineIds == null || medicineIds.isEmpty()) {
                ra.addFlashAttribute("error", "Please select at least one medicine");
                return "redirect:/pharmacist/new-prescription";
            }

            if (qty == null || qty.isEmpty()) {
                ra.addFlashAttribute("error", "Please provide quantities for all selected medicines");
                return "redirect:/pharmacist/new-prescription";
            }

            // Removed validation: "Number of medicines and quantities must match"
            // This validation was causing issues and is not needed

            Patient patient;

            // Check if existing patient selected or create new one
            if (selectedPatientId != null && !selectedPatientId.trim().isEmpty()) {
                // Use existing patient
                System.out.println("Using existing patient: " + selectedPatientId);
                patient = patientService.findByUserId(selectedPatientId.trim())
                        .orElseThrow(() -> new RuntimeException("Selected patient not found: " + selectedPatientId));
                System.out.println("Found existing patient: " + patient.getName());
            } else {
                // Create new patient
                System.out.println("Creating new patient");
                patient = new Patient();
                patient.setName(name.trim());

                if (age != null && age > 0) {
                    patient.setAge(age);
                }

                if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
                    patient.setPhoneNumber(phoneNumber.trim());
                }

                // Set default premium status
                patient.setPremiumMember(false);
                patient.setTotalPoints(0);

                // Save the new patient (this will auto-generate the ID)
                patient = patientService.save(patient);
                System.out.println("Created new patient with ID: " + patient.getUserId());
            }

            // Validate and clean up quantities
            for (int i = 0; i < qty.size(); i++) {
                if (qty.get(i) == null || qty.get(i) <= 0) {
                    ra.addFlashAttribute("error", "All quantities must be greater than 0");
                    return "redirect:/pharmacist/new-prescription";
                }
            }

            // Create prescription with medicines
            double total = service.registerPatientWithMedicines(patient, medicineIds, qty);
            System.out.println("Prescription created successfully. Total: Rs. " + total);

            ra.addFlashAttribute("success", "Prescription created successfully for " + patient.getName() + "!");
            ra.addFlashAttribute("total", String.format("Total Amount: Rs. %.2f", total));
            ra.addFlashAttribute("patientId", patient.getUserId());

        } catch (Exception e) {
            System.err.println("Error creating prescription: " + e.getMessage());
            e.printStackTrace();
            ra.addFlashAttribute("error", "Error creating prescription: " + e.getMessage());
        }

        return "redirect:/pharmacist/new-prescription";
    }

    @GetMapping("/prescriptions")
    public String allPrescriptions(Model model) {
        model.addAttribute("prescriptions", service.getAllPrescriptions());
        return "prescription-list";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("pending", service.getPendingWithMedicines());
        return "pharmacist-dashboard";
    }

    // All your existing medicine inventory and patient management methods...
    // (Keep all the existing methods exactly as they are)

    /* Medicine Inventory Methods */

    @GetMapping("/medicine-inventory")
    public String medicineInventory(Model model) {
        List<Medicine> medicines = service.getAllMedicinesWithInventoryInfo();
        Map<String, Long> categoryCounts = service.getMedicineCategoryCounts();
        List<String> medicineTypes = service.getAllMedicineTypes();

        model.addAttribute("medicines", medicines);
        model.addAttribute("categories", categoryCounts);
        model.addAttribute("medicineTypes", medicineTypes);

        return "medicine-inventory";
    }

    @GetMapping("/medicine-inventory/details/{id}")
    public String medicineDetails(@PathVariable Long id, Model model, RedirectAttributes ra) {
        try {
            Medicine medicine = service.getMedicineById(id);
            if (medicine == null) {
                ra.addFlashAttribute("error", "Medicine not found.");
                return "redirect:/pharmacist/medicine-inventory";
            }
            model.addAttribute("medicine", medicine);
            return "medicine-details";
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Error retrieving medicine details: " + ex.getMessage());
            return "redirect:/pharmacist/medicine-inventory";
        }
    }

    @GetMapping("/medicine-inventory/update-category/{id}")
    public String updateCategoryForm(@PathVariable Long id, Model model, RedirectAttributes ra) {
        try {
            Medicine medicine = service.getMedicineById(id);
            if (medicine == null) {
                ra.addFlashAttribute("error", "Medicine not found.");
                return "redirect:/pharmacist/medicine-inventory";
            }
            model.addAttribute("medicine", medicine);
            model.addAttribute("availableCategories", service.getAllCategories());
            return "update-medicine-category";
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Error loading update form: " + ex.getMessage());
            return "redirect:/pharmacist/medicine-inventory";
        }
    }

    @PostMapping("/medicine-inventory/update-category")
    public String updateCategory(@RequestParam Long medicineId,
                                 @RequestParam String category,
                                 RedirectAttributes ra) {
        try {
            // Validate inputs
            if (medicineId == null || category == null || category.trim().isEmpty()) {
                ra.addFlashAttribute("error", "Invalid category or medicine ID.");
                return "redirect:/pharmacist/medicine-inventory";
            }

            // Get medicine to check if it exists
            Medicine medicine = service.getMedicineById(medicineId);
            if (medicine == null) {
                ra.addFlashAttribute("error", "Medicine not found.");
                return "redirect:/pharmacist/medicine-inventory";
            }

            // Check if category is actually changing
            String currentCategory = medicine.getCategory();
            String newCategory = category.trim().toLowerCase();

            if (currentCategory != null && currentCategory.equalsIgnoreCase(newCategory)) {
                ra.addFlashAttribute("error", "Medicine is already in the selected category.");
                return "redirect:/pharmacist/medicine-inventory/update-category/" + medicineId;
            }

            // Update the category
            service.updateMedicineCategory(medicineId, newCategory);

            ra.addFlashAttribute("success",
                    String.format("Successfully updated %s category to '%s'",
                            medicine.getName(), newCategory));

        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Failed to update category: " + ex.getMessage());
            return "redirect:/pharmacist/medicine-inventory/update-category/" + medicineId;
        }

        return "redirect:/pharmacist/medicine-inventory";
    }

    @GetMapping("/medicine-inventory/search")
    @ResponseBody
    public List<Medicine> searchMedicines(@RequestParam(required = false) String query,
                                          @RequestParam(required = false) String category,
                                          @RequestParam(required = false) String type,
                                          @RequestParam(required = false) String stockLevel) {
        return service.searchMedicinesWithFilters(query, category, type, stockLevel);
    }

    // AJAX endpoint for real-time medicine search in prescription form
    @GetMapping("/search-medicines-ajax")
    @ResponseBody
    public List<Medicine> searchMedicinesAjax(@RequestParam String query) {
        if (query == null || query.trim().isEmpty()) {
            return List.of();
        }
        return service.searchMedicines(query.trim());
    }

    // Bulk category update endpoint
    @PostMapping("/medicine-inventory/bulk-update-category")
    public String bulkUpdateCategory(@RequestParam List<Long> medicineIds,
                                     @RequestParam String category,
                                     RedirectAttributes ra) {
        try {
            if (medicineIds == null || medicineIds.isEmpty()) {
                ra.addFlashAttribute("error", "No medicines selected for update.");
                return "redirect:/pharmacist/medicine-inventory";
            }

            int updatedCount = service.bulkUpdateMedicineCategory(medicineIds, category.trim().toLowerCase());

            ra.addFlashAttribute("success",
                    String.format("Successfully updated %d medicine(s) to category '%s'",
                            updatedCount, category.trim().toLowerCase()));

        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Failed to bulk update categories: " + ex.getMessage());
        }

        return "redirect:/pharmacist/medicine-inventory";
    }

    // Get category statistics
    @GetMapping("/medicine-inventory/category-stats")
    @ResponseBody
    public Map<String, Object> getCategoryStatistics() {
        return service.getCategoryStatistics();
    }

    /* Patient Management Methods */

    @GetMapping("/patients")
    public String patientsList(Model model) {
        model.addAttribute("patients", patientService.getAllPatients());
        return "patients-list";
    }

    @GetMapping("/patients/search")
    @ResponseBody
    public List<Patient> searchPatientsAjax(@RequestParam String query) {
        return patientService.searchPatientsByNameOrPhone(query);
    }

    @GetMapping("/patients/{userId}")
    public String patientDetails(@PathVariable String userId, Model model, RedirectAttributes ra) {
        try {
            Patient patient = patientService.findByUserId(userId)
                    .orElseThrow(() -> new RuntimeException("Patient not found"));
            model.addAttribute("patient", patient);
            return "patient-details";
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Error retrieving patient details: " + ex.getMessage());
            return "redirect:/pharmacist/patients";
        }
    }
}
