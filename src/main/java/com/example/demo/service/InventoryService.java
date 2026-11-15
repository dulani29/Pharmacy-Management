package com.example.demo.service;

import com.example.demo.model.Medicine;
import com.example.demo.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class InventoryService {

    @Autowired
    private MedicineRepository medicineRepository;

    // ✅ Basic CRUD operations
    public List<Medicine> getAllMedicines() {
        try {
            List<Medicine> medicines = medicineRepository.findAll();
            System.out.println("InventoryService.getAllMedicines() returned: " + medicines.size() + " medicines");
            return medicines;
        } catch (Exception e) {
            System.err.println("Error in getAllMedicines: " + e.getMessage());
            e.printStackTrace();
            return List.of();
        }
    }

    public Medicine getMedicineById(Long id) {
        return medicineRepository.findById(id).orElse(null);
    }

    public Medicine saveMedicine(Medicine medicine) {
        if (medicine.getLastRestockDate() == null) {
            medicine.setLastRestockDate(LocalDateTime.now());
        }
        return medicineRepository.save(medicine);
    }

    // ✅ Search methods
    public List<Medicine> searchMedicinesByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return getAllMedicines();
        }
        return medicineRepository.findByNameContainingIgnoreCase(name.trim());
    }

    // 🔧 ADDED: Enhanced search method that your controller might need
    public List<Medicine> searchMedicines(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllMedicines();
        }
        return medicineRepository.findByNameContainingIgnoreCaseOrCompanyContainingIgnoreCaseOrTypeContainingIgnoreCase(
                query, query, query);
    }

    // ✅ Validation methods
    public boolean isMedicineExists(String name) {
        return medicineRepository.existsByNameIgnoreCase(name);
    }

    // ✅ Stock management
    public List<Medicine> getLowStockMedicines() {
        return medicineRepository.findLowStockMedicines();
    }

    public List<Medicine> getExpiringSoonMedicines() {
        LocalDate threeMonthsFromNow = LocalDate.now().plusMonths(3);
        return medicineRepository.findExpiringSoon(threeMonthsFromNow);
    }

    // 🔧 ADDED: Alternative method with days parameter for flexibility
    public List<Medicine> getExpiringSoonMedicines(int days) {
        LocalDate cutoffDate = LocalDate.now().plusDays(days);
        return medicineRepository.findExpiringSoon(cutoffDate);
    }

    public void restockMedicine(Long id, int additionalQuantity) {
        Medicine medicine = getMedicineById(id);
        if (medicine != null) {
            medicine.restock(additionalQuantity);
            medicineRepository.save(medicine);
        }
    }

    // ✅ Medicine types for dropdown
    public String[] getMedicineTypes() {
        return new String[]{
                "Tablet", "Capsule", "Syrup", "Injection", "Cream", "Ointment",
                "Drop", "Spray", "Inhaler", "Powder", "Gel", "Lotion"
        };
    }

    // ✅ Category management
    public void updateCategory(Long medicineId, String newCategory) {
        Medicine medicine = medicineRepository.findById(medicineId).orElse(null);
        if (medicine != null) {
            medicine.setCategory(newCategory != null ? newCategory : "Uncategorized");
            medicineRepository.save(medicine);
        }
    }

    public void updateMedicineCategory(Long medicineId, String newCategory, String userRole) {
        // Check authorization
        if (!"admin".equalsIgnoreCase(userRole) && !"pharmacist".equalsIgnoreCase(userRole)) {
            throw new RuntimeException("Unauthorized: Only admin or pharmacist can update category.");
        }

        Medicine medicine = medicineRepository.findById(medicineId)
                .orElseThrow(() -> new RuntimeException("Medicine not found with ID: " + medicineId));

        medicine.setCategory(newCategory != null ? newCategory : "Uncategorized");
        medicineRepository.save(medicine);
    }

    public String[] getAvailableCategories() {
        return new String[]{
                "Pain Relief", "Antibiotics", "Vitamins", "Heart & Blood Pressure",
                "Diabetes", "Respiratory", "Digestive", "Skin Care",
                "Eye Care", "Mental Health", "Pregnancy & Baby", "Allergy",
                "Cold & Flu", "First Aid", "Supplements", "Uncategorized"
        };
    }

    // 🔧 ADDED: Dynamic categories from database
    public List<String> getAllCategories() {
        return medicineRepository.findDistinctCategories();
    }

    // ✅ Delete operations
    public void deleteMedicine(Long id, String userRole) {
        // Check if user has permission to delete (only admin and inventory managers)
        if (!"admin".equalsIgnoreCase(userRole) && !"inventory".equalsIgnoreCase(userRole)) {
            throw new RuntimeException("Access denied: Only admin and inventory managers can delete medicines");
        }

        // Check if medicine exists
        Medicine medicine = medicineRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Medicine not found with ID: " + id));

        try {
            medicineRepository.deleteById(id);
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete medicine: " + medicine.getName() + ". " + e.getMessage());
        }
    }

    public void deleteById(Long id) {
        medicineRepository.deleteById(id);
    }

    // 🔧 ADDED: Statistics methods for dashboard
    public long getTotalMedicineCount() {
        return medicineRepository.count();
    }

    public long getLowStockCount() {
        return getLowStockMedicines().size();
    }

    public long getCategoryCount() {
        try {
            return medicineRepository.countDistinctCategories();
        } catch (Exception e) {
            return getAllCategories().size();
        }
    }

    public int getRecentRestockCount() {
        // Count medicines restocked in last 7 days
        LocalDateTime weekAgo = LocalDateTime.now().minusDays(7);
        // You would need to add this query to repository, for now return 0
        return 0;
    }

    // 🔧 ADDED: Advanced search with filters
    public List<Medicine> findMedicinesWithFilters(String name, String category, String type) {
        return medicineRepository.findMedicinesWithFilters(name, category, type);
    }

    // 🔧 ADDED: Bulk operations
    public void bulkDeleteMedicines(List<Long> medicineIds, String userRole) {
        for (Long id : medicineIds) {
            deleteMedicine(id, userRole);
        }
    }

    // 🔧 ADDED: Utility methods
    public List<Medicine> findByName(String name) {
        return medicineRepository.findByNameContainingIgnoreCase(name);
    }

    public List<Medicine> findByType(String type) {
        return medicineRepository.findByTypeIgnoreCase(type);
    }

    public List<Medicine> findByCompany(String company) {
        return medicineRepository.findByCompanyIgnoreCase(company);
    }
}
