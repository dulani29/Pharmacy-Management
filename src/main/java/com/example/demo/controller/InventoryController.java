package com.example.demo.controller;

import com.example.demo.model.Medicine;
import com.example.demo.service.MedicineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/inventory")
public class InventoryController {

    @Autowired
    private MedicineService medicineService; // Changed from InventoryService

    @GetMapping("/dashboard")
    public String inventoryDashboard(Model model, HttpSession session,
                                     @RequestParam(required = false) String search,
                                     RedirectAttributes redirectAttributes) {
        // Check if user is inventory manager
        String userRole = (String) session.getAttribute("userRole");
        if (!"inventory".equalsIgnoreCase(userRole)) {
            redirectAttributes.addFlashAttribute("error", "Access denied");
            return "redirect:/login";
        }

        System.out.println("=== INVENTORY DASHBOARD DEBUG ===");
        System.out.println("User role: " + userRole);
        System.out.println("Search param: " + search);

        try {
            // Get all medicines or search results
            List<Medicine> medicines;
            if (search != null && !search.trim().isEmpty()) {
                medicines = medicineService.searchMedicines(search.trim());
                model.addAttribute("searchTerm", search.trim());
                model.addAttribute("searchPerformed", true);
                System.out.println("Search performed for: " + search.trim());
            } else {
                medicines = medicineService.getAllMedicines();
                model.addAttribute("searchPerformed", false);
                System.out.println("Getting all medicines");
            }

            System.out.println("Medicines found: " + medicines.size());

            // Debug: Print first few medicines
            for (int i = 0; i < Math.min(3, medicines.size()); i++) {
                Medicine m = medicines.get(i);
                System.out.println("Medicine " + (i+1) + ": " + m.getName() + " - " + m.getQuantity() + " units");
            }

            // Get low stock medicines
            List<Medicine> lowStockItems = medicineService.getLowStockMedicines();
            System.out.println("Low stock items: " + lowStockItems.size());

            // Add to model
            model.addAttribute("medicines", medicines);
            model.addAttribute("lowStockItems", lowStockItems);
            model.addAttribute("totalMedicines", medicines.size());
            model.addAttribute("lowStockCount", lowStockItems.size());
            model.addAttribute("totalCategories", medicineService.getAllCategories().size());
            model.addAttribute("recentRestock", 0); // You can implement this later
            model.addAttribute("user", session.getAttribute("loggedInUser"));

            System.out.println("=== END INVENTORY DASHBOARD DEBUG ===");

        } catch (Exception e) {
            System.err.println("Error in inventory dashboard: " + e.getMessage());
            e.printStackTrace();

            // Add empty data to prevent JSP errors
            model.addAttribute("medicines", List.of());
            model.addAttribute("lowStockItems", List.of());
            model.addAttribute("totalMedicines", 0);
            model.addAttribute("lowStockCount", 0);
            model.addAttribute("totalCategories", 0);
            model.addAttribute("recentRestock", 0);
            model.addAttribute("error", "Error loading inventory data: " + e.getMessage());
        }

        return "inventory-dashboard";
    }

    @GetMapping("/add-stock")
    public String showAddStockPage(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        // Check user role
        String userRole = (String) session.getAttribute("userRole");
        if (!"inventory".equalsIgnoreCase(userRole)) {
            redirectAttributes.addFlashAttribute("error", "Access denied");
            return "redirect:/login";
        }

        model.addAttribute("medicine", new Medicine());
        model.addAttribute("medicineTypes", new String[]{"Tablet", "Capsule", "Syrup", "Injection", "Cream", "Drops"});
        model.addAttribute("user", session.getAttribute("loggedInUser"));

        return "add-inventory";
    }

    @PostMapping("/add-stock")
    public String addStock(@ModelAttribute Medicine medicine, RedirectAttributes redirectAttributes,
                           HttpSession session) {
        // Check user role
        String userRole = (String) session.getAttribute("userRole");
        if (!"inventory".equalsIgnoreCase(userRole)) {
            redirectAttributes.addFlashAttribute("error", "Access denied");
            return "redirect:/login";
        }

        try {
            // Check if medicine already exists
            if (medicineService.existsByName(medicine.getName())) {
                redirectAttributes.addFlashAttribute("error",
                        "Medicine with this name already exists. Please use restock function.");
                return "redirect:/inventory/add-stock";
            }

            medicineService.saveMedicine(medicine);
            redirectAttributes.addFlashAttribute("success",
                    "Medicine '" + medicine.getName() + "' added successfully!");
            return "redirect:/inventory/dashboard";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Error adding medicine: " + e.getMessage());
            return "redirect:/inventory/add-stock";
        }
    }

    @PostMapping("/restock/{id}")
    public String restockMedicine(@PathVariable Long id, @RequestParam(defaultValue = "50") int quantity,
                                  RedirectAttributes redirectAttributes, HttpSession session) {
        // Check user role
        String userRole = (String) session.getAttribute("userRole");
        if (!"inventory".equalsIgnoreCase(userRole)) {
            redirectAttributes.addFlashAttribute("error", "Access denied");
            return "redirect:/login";
        }

        try {
            Medicine medicine = medicineService.getMedicineById(id);
            if (medicine == null) {
                redirectAttributes.addFlashAttribute("error", "Medicine not found");
                return "redirect:/inventory/dashboard";
            }

            // Restock the medicine
            medicine.restock(quantity);
            medicineService.saveMedicine(medicine);

            redirectAttributes.addFlashAttribute("success",
                    medicine.getName() + " restocked with " + quantity + " units successfully!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Error restocking medicine: " + e.getMessage());
        }

        return "redirect:/inventory/dashboard";
    }

    @PostMapping("/update-category/{id}")
    public String updateCategory(@PathVariable Long id, @RequestParam String category,
                                 RedirectAttributes redirectAttributes, HttpSession session) {
        // Check if user is pharmacist or admin
        String userRole = (String) session.getAttribute("userRole");
        if (!"pharmacist".equalsIgnoreCase(userRole) && !"admin".equalsIgnoreCase(userRole)) {
            redirectAttributes.addFlashAttribute("error",
                    "Only pharmacists and admins can update medicine categories");
            return "redirect:/inventory/dashboard";
        }

        try {
            Medicine medicine = medicineService.getMedicineById(id);
            if (medicine == null) {
                redirectAttributes.addFlashAttribute("error", "Medicine not found");
                return "redirect:/inventory/dashboard";
            }

            medicine.setCategory(category);
            medicineService.saveMedicine(medicine);

            redirectAttributes.addFlashAttribute("success",
                    "Category updated successfully for " + medicine.getName());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Error updating category: " + e.getMessage());
        }

        return "redirect:/inventory/dashboard";
    }

    // NEW: Get medicine categories for AJAX
    @GetMapping("/categories")
    @ResponseBody
    public String[] getCategories() {
        List<String> categories = medicineService.getAllCategories();
        return categories.toArray(new String[0]);
    }

    @PostMapping("/delete/{id}")
    public String deleteMedicine(@PathVariable Long id,
                                 RedirectAttributes redirectAttributes,
                                 HttpSession session) {
        try {
            // Get user role for permission check
            String userRole = (String) session.getAttribute("userRole");

            if (!"inventory".equalsIgnoreCase(userRole) && !"admin".equalsIgnoreCase(userRole)) {
                redirectAttributes.addFlashAttribute("error", "Insufficient permissions to delete medicine");
                return "redirect:/inventory/dashboard";
            }

            // Get medicine details before deletion for confirmation message
            Medicine medicine = medicineService.getMedicineById(id);
            String medicineName = medicine != null ? medicine.getName() : "Medicine";

            // Delete the medicine
            medicineService.deleteMedicine(id);

            redirectAttributes.addFlashAttribute("success",
                    "'" + medicineName + "' has been successfully deleted from inventory.");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Error deleting medicine: " + e.getMessage());
        }

        return "redirect:/inventory/dashboard";
    }

    /**
     * Bulk delete endpoint (optional)
     */
    @PostMapping("/delete-multiple")
    public String deleteMedicines(@RequestParam("medicineIds") List<Long> medicineIds,
                                  RedirectAttributes redirectAttributes,
                                  HttpSession session) {
        try {
            String userRole = (String) session.getAttribute("userRole");

            if (!"inventory".equalsIgnoreCase(userRole) && !"admin".equalsIgnoreCase(userRole)) {
                redirectAttributes.addFlashAttribute("error", "Insufficient permissions");
                return "redirect:/inventory/dashboard";
            }

            for (Long id : medicineIds) {
                medicineService.deleteMedicine(id);
            }

            redirectAttributes.addFlashAttribute("success",
                    medicineIds.size() + " medicines deleted successfully.");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Error deleting medicines: " + e.getMessage());
        }

        return "redirect:/inventory/dashboard";
    }
}
