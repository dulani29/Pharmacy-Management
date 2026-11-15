package com.example.demo.service;

import com.example.demo.model.Medicine;
import com.example.demo.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class MedicineService {

    @Autowired
    private MedicineRepository medicineRepository;

    // Basic CRUD operations
    // In MedicineService.java
    public List<Medicine> getAllMedicines() {
        try {
            List<Medicine> medicines = medicineRepository.findAll(); // Use findAll() instead of findAllByOrderByNameAsc() for debugging
            System.out.println("MedicineService.getAllMedicines() returned: " + medicines.size() + " medicines");
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
        return medicineRepository.save(medicine);
    }

    public void deleteMedicine(Long id) {
        medicineRepository.deleteById(id);
    }

    // Search and filter methods
    public List<Medicine> searchMedicines(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllMedicines();
        }
        // FIXED: Using the correct method signature and parameter order
        return medicineRepository.findByNameContainingIgnoreCaseOrCompanyContainingIgnoreCaseOrTypeContainingIgnoreCase(
                query, query, query);
    }

    public List<Medicine> getMedicinesByCategory(String category) {
        return medicineRepository.findByCategoryIgnoreCase(category);
    }

    public List<String> getAllCategories() {
        return medicineRepository.findDistinctCategories();
    }

    public List<String> getAllTypes() {
        return medicineRepository.findDistinctTypes();
    }

    public List<String> getAllCompanies() {
        return medicineRepository.findDistinctCompanies();
    }

    // Statistics methods
    public long getTotalMedicineCount() {
        return medicineRepository.count();
    }

    public long getLowStockCount(int threshold) {
        return medicineRepository.countByQuantityLessThan(threshold);
    }

    public long getExpiringSoonCount(int days) {
        LocalDate cutoffDate = LocalDate.now().plusDays(days);
        return medicineRepository.countByExpiryDateBefore(cutoffDate);
    }

    public List<Medicine> getLowStockMedicines(int threshold) {
        return medicineRepository.findByQuantityLessThanOrderByQuantityAsc(threshold);
    }

    public List<Medicine> getExpiringSoonMedicines(int days) {
        LocalDate cutoffDate = LocalDate.now().plusDays(days);
        return medicineRepository.findByExpiryDateBeforeOrderByExpiryDateAsc(cutoffDate);
    }

    // Stock level methods
    public List<Medicine> getLowStockMedicines() {
        return medicineRepository.findLowStockMedicines();
    }

    public List<Medicine> getOutOfStockMedicines() {
        return medicineRepository.findOutOfStockMedicines();
    }

    public List<Medicine> getHighStockMedicines() {
        return medicineRepository.findHighStockMedicines();
    }

    // Price management methods
    public void updateMedicinePrice(Long id, double newPrice) {
        Medicine medicine = getMedicineById(id);
        if (medicine != null) {
            medicine.setPrice(newPrice);
            saveMedicine(medicine);
        }
    }

    public void bulkUpdatePrices(List<Long> medicineIds, List<Double> newPrices) {
        for (int i = 0; i < medicineIds.size(); i++) {
            if (i < newPrices.size()) {
                updateMedicinePrice(medicineIds.get(i), newPrices.get(i));
            }
        }
    }

    // Advanced search with filters
    public List<Medicine> searchMedicinesWithFilters(String query, String category, String type, String stockLevel) {
        return medicineRepository.findMedicinesWithAdvancedFilters(query, category, type, stockLevel);
    }

    // Category management
    public long getMedicineCountByCategory(String category) {
        return medicineRepository.countByCategory(category);
    }

    public List<Medicine> getUncategorizedMedicines() {
        return medicineRepository.findUncategorizedMedicines();
    }

    // Inventory reports
    public List<Object[]> getCategoryReport() {
        return medicineRepository.getInventoryReportByCategory();
    }

    public List<Object[]> getTypeReport() {
        return medicineRepository.getInventoryReportByType();
    }

    public List<Object[]> getCompanyReport() {
        return medicineRepository.getInventoryReportByCompany();
    }

    // Utility methods
    public boolean existsByName(String name) {
        return medicineRepository.existsByNameIgnoreCase(name);
    }

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
