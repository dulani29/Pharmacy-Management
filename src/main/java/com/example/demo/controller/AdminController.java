package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.service.AdminService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.example.demo.model.Medicine;
import com.example.demo.service.MedicineService;
import com.example.demo.model.Patient;
import com.example.demo.model.PointsTransaction;
import com.example.demo.repository.PatientRepository;
import com.example.demo.repository.PointsTransactionRepository;
import com.example.demo.repository.PaymentRepository;
import com.example.demo.model.Payment;
import com.example.demo.repository.PrescriptionRepository;

import java.util.List;
import java.util.Map;
import java.util.Comparator;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/admin")
public class AdminController {


    @Autowired
    private MedicineService medicineService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private PointsTransactionRepository pointsTransactionRepository;

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private PrescriptionRepository prescriptionRepository;

    /* ---------- DASHBOARD ---------- */
    @GetMapping("/dashboard")
    public String adminDashboard(Model model) {
        model.addAttribute("totalUsers",  adminService.getTotalUsersCount());
        model.addAttribute("activeUsers", adminService.getActiveUsersCount());
        model.addAttribute("totalPharmacists", adminService.getUserCountByRole("pharmacist"));
        model.addAttribute("totalCashiers",    adminService.getUserCountByRole("cashier"));
        model.addAttribute("totalInventory",   adminService.getUserCountByRole("inventory"));
        return "admin-dashboard";
    }

    /* ---------- ADD USER ---------- */
    @GetMapping("/add-user")
    public String addUserForm(Model model) {
        model.addAttribute("user", new User());
        return "add-user";
    }

    @PostMapping("/add-user")
    public String addUser(@ModelAttribute User user, RedirectAttributes redirect) {
        if (adminService.existsByUsername(user.getUsername())) {
            redirect.addFlashAttribute("error", "Username already exists!");
            return "redirect:/add-user";
        }
        if (adminService.existsByEmail(user.getEmail())) {
            redirect.addFlashAttribute("error", "Email already exists!");
            return "redirect:/add-user";
        }
        adminService.save(user);
        redirect.addFlashAttribute("success",
                "User '" + user.getUsername() + "' created successfully!");
        return "redirect:/admin/add-user";           // shows popup on add-user.jsp then redirects itself
    }

    @GetMapping("/offers")
    public String offersManagement(@RequestParam(required = false) String search,
                                   @RequestParam(required = false) String category,
                                   @RequestParam(required = false) String sortBy,
                                   Model model) {

        System.out.println("=== ADMIN OFFERS DEBUG ===");
        System.out.println("Search: " + search);
        System.out.println("Category: " + category);
        System.out.println("SortBy: " + sortBy);

        try {
            List<Medicine> medicines;

            // Get all medicines first (simplest approach)
            medicines = medicineService.getAllMedicines();
            System.out.println("Initial medicines found: " + medicines.size());

            // Apply search filter if provided
            if (search != null && !search.trim().isEmpty()) {
                System.out.println("Applying search filter for: " + search.trim());
                medicines = medicines.stream()
                        .filter(m -> m.getName().toLowerCase().contains(search.trim().toLowerCase()) ||
                                (m.getCompany() != null && m.getCompany().toLowerCase().contains(search.trim().toLowerCase())) ||
                                (m.getType() != null && m.getType().toLowerCase().contains(search.trim().toLowerCase())))
                        .collect(java.util.stream.Collectors.toList());
                model.addAttribute("search", search.trim());
                System.out.println("After search filter: " + medicines.size());
            }

            // Apply category filter if provided
            if (category != null && !category.trim().isEmpty() && !"all".equals(category) && !category.equals("")) {
                System.out.println("Applying category filter for: " + category);
                medicines = medicines.stream()
                        .filter(m -> m.getCategory() != null && m.getCategory().equalsIgnoreCase(category))
                        .collect(java.util.stream.Collectors.toList());
                model.addAttribute("category", category);
                System.out.println("After category filter: " + medicines.size());
            }

            // Apply sorting
            if ("name".equals(sortBy)) {
                medicines.sort((a, b) -> a.getName().compareToIgnoreCase(b.getName()));
            } else if ("price_low".equals(sortBy)) {
                medicines.sort((a, b) -> Double.compare(a.getPrice(), b.getPrice()));
            } else if ("price_high".equals(sortBy)) {
                medicines.sort((a, b) -> Double.compare(b.getPrice(), a.getPrice()));
            } else if ("stock_low".equals(sortBy)) {
                medicines.sort((a, b) -> Integer.compare(a.getQuantity(), b.getQuantity()));
            }

            // Get statistics
            long totalMedicines = medicineService.getTotalMedicineCount();
            long lowStockCount = 0;
            long expiringSoonCount = 0;

            try {
                lowStockCount = medicineService.getLowStockCount(10);
            } catch (Exception e) {
                System.err.println("Error getting low stock count: " + e.getMessage());
            }

            try {
                expiringSoonCount = medicineService.getExpiringSoonCount(30);
            } catch (Exception e) {
                System.err.println("Error getting expiring soon count: " + e.getMessage());
            }

            // Get categories
            List<String> categories = new java.util.ArrayList<>();
            try {
                categories = medicineService.getAllCategories();
            } catch (Exception e) {
                System.err.println("Error getting categories: " + e.getMessage());
                // Fallback: get unique categories from current medicines
                categories = medicines.stream()
                        .map(Medicine::getCategory)
                        .filter(cat -> cat != null && !cat.trim().isEmpty())
                        .distinct()
                        .sorted()
                        .collect(java.util.stream.Collectors.toList());
            }

            System.out.println("=== FINAL RESULTS ===");
            System.out.println("Total medicines: " + totalMedicines);
            System.out.println("Filtered medicines: " + medicines.size());
            System.out.println("Categories: " + categories.size());
            System.out.println("Low stock: " + lowStockCount);
            System.out.println("Expiring soon: " + expiringSoonCount);

            // Add to model
            model.addAttribute("medicines", medicines);
            model.addAttribute("categories", categories);
            model.addAttribute("totalMedicines", totalMedicines);
            model.addAttribute("lowStockCount", lowStockCount);
            model.addAttribute("expiringSoonCount", expiringSoonCount);
            model.addAttribute("sortBy", sortBy);

        } catch (Exception e) {
            System.err.println("ERROR in offers method: " + e.getMessage());
            e.printStackTrace();

            // Set error message and empty data
            model.addAttribute("error", "Error loading medicines: " + e.getMessage());
            model.addAttribute("medicines", new java.util.ArrayList<>());
            model.addAttribute("categories", new java.util.ArrayList<>());
            model.addAttribute("totalMedicines", 0L);
            model.addAttribute("lowStockCount", 0L);
            model.addAttribute("expiringSoonCount", 0L);
        }

        System.out.println("=== END ADMIN OFFERS DEBUG ===");
        return "offers-management";
    }


    @PostMapping("/update-medicine-price")
    public String updateMedicinePrice(@RequestParam Long medicineId,
                                      @RequestParam double newPrice,
                                      @RequestParam(required = false) String reason,
                                      RedirectAttributes redirect) {
        try {
            System.out.println("Updating medicine " + medicineId + " price to " + newPrice);

            Medicine medicine = medicineService.getMedicineById(medicineId);
            if (medicine == null) {
                redirect.addFlashAttribute("error", "Medicine not found!");
                return "redirect:/admin/offers";
            }

            double oldPrice = medicine.getPrice();
            medicine.setPrice(newPrice);
            medicineService.saveMedicine(medicine);

            // Log the price change if you have the method
            try {
                String changeReason = reason != null && !reason.trim().isEmpty() ? reason : "Price updated by admin";
                adminService.logPriceChange(medicineId, oldPrice, newPrice, changeReason);
            } catch (Exception e) {
                System.err.println("Could not log price change: " + e.getMessage());
            }

            redirect.addFlashAttribute("success",
                    String.format("Price updated for %s: Rs. %.2f → Rs. %.2f",
                            medicine.getName(), oldPrice, newPrice));

        } catch (Exception e) {
            System.err.println("Error updating price: " + e.getMessage());
            redirect.addFlashAttribute("error", "Error updating price: " + e.getMessage());
        }

        return "redirect:/admin/offers";
    }

    @PostMapping("/bulk-update-prices")
    public String bulkUpdatePrices(@RequestParam List<Long> medicineIds,
                                   @RequestParam List<Double> newPrices,
                                   @RequestParam(required = false) String reason,
                                   RedirectAttributes redirect) {
        try {
            int updatedCount = 0;
            String changeReason = reason != null && !reason.trim().isEmpty() ? reason : "Bulk price update by admin";

            for (int i = 0; i < medicineIds.size(); i++) {
                Long medicineId = medicineIds.get(i);
                Double newPrice = newPrices.get(i);

                Medicine medicine = medicineService.getMedicineById(medicineId);
                if (medicine != null && newPrice > 0) {
                    double oldPrice = medicine.getPrice();
                    medicine.setPrice(newPrice);
                    medicineService.saveMedicine(medicine);

                    // Log the price change
                    adminService.logPriceChange(medicineId, oldPrice, newPrice, changeReason);
                    updatedCount++;
                }
            }

            redirect.addFlashAttribute("success",
                    String.format("Successfully updated prices for %d medicines", updatedCount));

        } catch (Exception e) {
            redirect.addFlashAttribute("error", "Error updating prices: " + e.getMessage());
        }

        return "redirect:/admin/offers";
    }

    @GetMapping("/price-history/{medicineId}")
    @ResponseBody
    public List<Map<String, Object>> getPriceHistory(@PathVariable Long medicineId) {
        return adminService.getPriceHistory(medicineId);
    }

    /* ---------- LIST USERS ---------- */
    @GetMapping("/users")
    public String listUsers(Model model,
                            @ModelAttribute("success") String success,
                            @ModelAttribute("error")   String error) {
        model.addAttribute("users", adminService.findAll());
        model.addAttribute("success", success);
        model.addAttribute("error",   error);
        return "user-management";
    }

    /* ---------- EDIT USER ---------- */
    @GetMapping("/edit-user/{id}")
    public String editUserForm(@PathVariable Long id, Model model, RedirectAttributes redirect) {
        User user = adminService.findById(id);
        if (user == null) {
            redirect.addFlashAttribute("error", "User not found!");
            return "redirect:/admin/users";
        }
        model.addAttribute("user", user);
        return "update-user";
    }

    @PostMapping("/update-user")
    public String updateUser(@ModelAttribute User user, RedirectAttributes redirect) {
        User existing = adminService.findById(user.getId());
        if (existing == null) {
            redirect.addFlashAttribute("error", "User not found!");
            return "redirect:/admin/users";
        }
        if (user.getPassword() == null || user.getPassword().isBlank()) {
            user.setPassword(existing.getPassword());
        }
        adminService.save(user);
        redirect.addFlashAttribute("success",
                "User '" + user.getUsername() + "' updated successfully!");
        return "redirect:/admin/users";
    }

    /* ---------- DELETE USER ---------- */
    @PostMapping("/delete-user/{id}")
    public String deleteUser(@PathVariable Long id,
                             RedirectAttributes redirect,
                             HttpSession session) {
        User user = adminService.findById(id);
        if (user == null) {
            redirect.addFlashAttribute("error", "User not found!");
            return "redirect:/admin/users";
        }
        String current = (String) session.getAttribute("username");
        if (user.getUsername().equals(current)) {
            redirect.addFlashAttribute("error", "You cannot delete your own account!");
            return "redirect:/admin/users";
        }
        adminService.deleteById(id);
        redirect.addFlashAttribute("success",
                "User '" + user.getUsername() + "' deleted successfully!");
        return "redirect:/admin/users";
    }

    /* ---------- TOGGLE STATUS ---------- */
    @PostMapping("/toggle-status/{id}")
    public String toggleUserStatus(@PathVariable Long id, RedirectAttributes redirect) {
        User user = adminService.findById(id);
        if (user == null) {
            redirect.addFlashAttribute("error", "User not found!");
            return "redirect:/admin/users";
        }
        boolean newStatus = !user.isActive();
        adminService.updateUserStatus(id, newStatus);
        redirect.addFlashAttribute("success",
                "User '" + user.getUsername() + "' " + (newStatus ? "activated" : "deactivated") + " successfully!");
        return "redirect:/admin/users";
    }

    /* ---------- LOYALTY MEMBERS ---------- */
    @GetMapping("/loyalty-members")
    public String loyaltyMembers(@RequestParam(value = "userId", required = false) String userId, Model model) {
        List<Patient> members = patientRepository.findByIsPremiumMember(true);
        model.addAttribute("members", members);

        if (userId != null && !userId.isBlank()) {
            patientRepository.findByUserId(userId).ifPresent(p -> {
                model.addAttribute("selectedMember", p);
                List<PointsTransaction> txns = pointsTransactionRepository.findByPatientUserIdOrderByTransactionDateDesc(userId);
                model.addAttribute("transactions", txns);
            });
        }

        return "loyalty-members";
    }

    @PostMapping("/loyalty-member/{userId}/remove")
    public String removeLoyaltyMember(@PathVariable("userId") String userId, RedirectAttributes redirectAttributes) {
        try {
            Patient patient = patientRepository.findByUserId(userId)
                    .orElseThrow(() -> new IllegalArgumentException("Patient not found"));

            patient.setPremiumMember(false);
            patient.setTotalPoints(0);
            patientRepository.save(patient);

            redirectAttributes.addFlashAttribute("success", "Removed loyalty membership for " + patient.getName());
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("error", "Failed to remove loyalty membership: " + ex.getMessage());
        }
        return "redirect:/admin/loyalty-members";
    }

    @PostMapping("/loyalty-member/{userId}/delete")
    public String deleteLoyaltyMember(@PathVariable("userId") String userId, RedirectAttributes redirectAttributes) {
        try {
            Patient patient = patientRepository.findByUserId(userId)
                    .orElseThrow(() -> new IllegalArgumentException("Patient not found"));

            // Delete related resources first (FK safety)
            try {
                pointsTransactionRepository.deleteByPatientUserId(patient.getUserId());
            } catch (Exception ignored) {}

            try {
                paymentRepository.deleteByPatientUserId(patient.getUserId());
            } catch (Exception ignored) {}

            try {
                prescriptionRepository.deleteByPatientUserId(patient.getUserId());
            } catch (Exception ignored) {}

            patientRepository.deleteById(patient.getUserId());
            redirectAttributes.addFlashAttribute("success", "Deleted member " + patient.getName() + " (" + patient.getUserId() + ")");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete member: " + ex.getMessage());
        }
        return "redirect:/admin/loyalty-members";
    }

    /* ---------- GUEST CUSTOMERS ---------- */
    @GetMapping("/guests")
    public String guestCustomers(@RequestParam(value = "userId", required = false) String userId, Model model) {
        List<Patient> guests = patientRepository.findByIsPremiumMember(false);
        model.addAttribute("guests", guests);

        if (userId != null && !userId.isBlank()) {
            patientRepository.findByUserId(userId).ifPresent(p -> {
                model.addAttribute("selectedGuest", p);
                List<Payment> payments = paymentRepository.findByPatientUserId(userId);
                // Sort newest first, treating null dates as oldest
                payments.sort(Comparator.comparing(
                        (Payment pay) -> {
                            LocalDateTime dt = pay.getPaymentDate();
                            return dt != null ? dt : LocalDateTime.MIN;
                        },
                        Comparator.reverseOrder()
                ));
                model.addAttribute("payments", payments);
            });
        }

        return "guest-customers";
    }

    @PostMapping("/guest/{userId}/delete")
    public String deleteGuest(@PathVariable("userId") String userId, RedirectAttributes redirectAttributes) {
        try {
            Patient patient = patientRepository.findByUserId(userId)
                    .orElseThrow(() -> new IllegalArgumentException("Patient not found"));
            // Delete related resources first (FK safety)
            try { pointsTransactionRepository.deleteByPatientUserId(patient.getUserId()); } catch (Exception ignored) {}
            try { paymentRepository.deleteByPatientUserId(patient.getUserId()); } catch (Exception ignored) {}
            try { prescriptionRepository.deleteByPatientUserId(patient.getUserId()); } catch (Exception ignored) {}

            patientRepository.deleteById(patient.getUserId());
            redirectAttributes.addFlashAttribute("success", "Deleted guest customer " + patient.getName() + " (" + patient.getUserId() + ")");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete guest: " + ex.getMessage());
        }
        return "redirect:/admin/guests";
    }
}
