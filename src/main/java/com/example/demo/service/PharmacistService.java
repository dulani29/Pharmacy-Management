package com.example.demo.service;

import com.example.demo.model.Medicine;
import com.example.demo.model.Patient;
import com.example.demo.model.Payment;
import com.example.demo.model.Prescription;
import com.example.demo.repository.MedicineRepository;
import com.example.demo.repository.PatientRepository;
import com.example.demo.repository.PaymentRepository;
import com.example.demo.repository.PrescriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PharmacistService {

    private final PaymentRepository paymentRepo;
    private final PatientRepository patientRepo;
    private final MedicineRepository medicineRepo;
    private final PrescriptionRepository prescriptionRepo;

    @Autowired
    public PharmacistService(PatientRepository patientRepo,
                             MedicineRepository medicineRepo,
                             PrescriptionRepository prescriptionRepo,
                             PaymentRepository paymentRepo) {
        this.patientRepo = patientRepo;
        this.medicineRepo = medicineRepo;
        this.prescriptionRepo = prescriptionRepo;
        this.paymentRepo = paymentRepo;
    }

    /* ── medicines ─────────────────────────────────────────── */
    public List<Medicine> getAllMedicines() {
        return medicineRepo.findAll();
    }

    public List<Medicine> searchMedicines(String q) {
        return medicineRepo.findByNameContainingIgnoreCaseOrTypeContainingIgnoreCaseOrCompanyContainingIgnoreCase(q, q, q);
    }

    /* ── create prescription + update stock + payment ────────────────── */
    @Transactional
    public double registerPatientWithMedicines(Patient patient,
                                               List<Long> medicineIds,
                                               List<Integer> quantities) {

        System.out.println("=== REGISTERING PATIENT WITH MEDICINES ===");
        System.out.println("Patient: " + patient.getName() + " (ID: " + patient.getUserId() + ")");
        System.out.println("Medicine IDs: " + medicineIds);
        System.out.println("Quantities: " + quantities);
        
        // Validate input arrays
        if (medicineIds == null || medicineIds.isEmpty()) {
            throw new RuntimeException("No medicine IDs provided");
        }
        if (quantities == null || quantities.isEmpty()) {
            throw new RuntimeException("No quantities provided");
        }
        if (medicineIds.size() != quantities.size()) {
            System.err.println("WARNING: Array size mismatch - Medicine IDs: " + medicineIds.size() + ", Quantities: " + quantities.size());
            System.err.println("This will be handled gracefully by skipping missing quantities");
        }

        // Ensure patient is saved (should already be saved, but just in case)
        Patient savedPatient;
        if (patient.getUserId() == null) {
            System.out.println("Patient ID is null, saving patient first...");
            savedPatient = patientRepo.save(patient);
        } else {
            savedPatient = patient;
        }

        System.out.println("Using patient with ID: " + savedPatient.getUserId());

        double grandTotal = 0.0;

        // Create prescriptions and update stock
        for (int i = 0; i < medicineIds.size(); i++) {
            Long medId = medicineIds.get(i);
            
            // Add bounds checking to prevent IndexOutOfBoundsException
            int qty = 1; // Default quantity if not provided
            if (i < quantities.size()) {
                qty = quantities.get(i);
            } else {
                System.err.println("WARNING: No quantity found for medicine ID " + medId + " at index " + i);
                System.err.println("Medicine IDs size: " + medicineIds.size() + ", Quantities size: " + quantities.size());
                System.err.println("Using default quantity of 1 for medicine ID: " + medId);
            }

            System.out.println("Processing medicine ID: " + medId + ", quantity: " + qty);

            if (qty <= 0) {
                System.out.println("Skipping medicine " + medId + " - quantity is " + qty);
                continue;
            }

            Medicine medicine = medicineRepo.findById(medId)
                    .orElseThrow(() -> new RuntimeException("Medicine " + medId + " not found"));

            System.out.println("Found medicine: " + medicine.getName() + " (Stock: " + medicine.getQuantity() + ")");

            if (medicine.getQuantity() < qty) {
                throw new RuntimeException(medicine.getName() + " - only " + medicine.getQuantity() + " in stock, but " + qty + " requested");
            }

            // Create prescription
            Prescription prescription = new Prescription();
            prescription.setPatient(savedPatient);
            prescription.setMedicine(medicine);
            prescription.setQty(qty);
            prescription.setStatus("PAYMENT_PENDING");

            Prescription savedPrescription = prescriptionRepo.save(prescription);
            System.out.println("Created prescription with ID: " + savedPrescription.getId());

            // Update stock
            int newQuantity = medicine.getQuantity() - qty;
            medicine.setQuantity(newQuantity);
            medicineRepo.save(medicine);
            System.out.println("Updated medicine stock: " + medicine.getName() + " from " + (newQuantity + qty) + " to " + newQuantity);

            double itemTotal = qty * medicine.getPrice();
            grandTotal += itemTotal;
            System.out.println("Item total: Rs. " + itemTotal + " (Qty: " + qty + " x Price: Rs. " + medicine.getPrice() + ")");
        }

        System.out.println("Grand total: Rs. " + grandTotal);

        // Create or update payment record for the patient
        List<Payment> existingPayments = paymentRepo.findByPatientUserId(savedPatient.getUserId());
        Payment payment;

        if (existingPayments.isEmpty()) {
            System.out.println("Creating new payment record");
            payment = new Payment();
            payment.setPatient(savedPatient);
        } else {
            // Find existing pending payment or create new one
            payment = existingPayments.stream()
                    .filter(p -> "PENDING".equals(p.getPaymentStatus()))
                    .findFirst()
                    .orElse(null);

            if (payment == null) {
                System.out.println("Creating new payment record (no pending payment found)");
                payment = new Payment();
                payment.setPatient(savedPatient);
            } else {
                System.out.println("Updating existing pending payment");
            }
        }

        payment.setPaymentStatus("PENDING");
        payment.setPaymentMethod("CASH"); // default, cashier updates later
        payment.setTotal(grandTotal);
        payment.setOriginalTotal(grandTotal);
        Payment savedPayment = paymentRepo.save(payment);

        System.out.println("Saved payment with ID: " + savedPayment.getId());
        System.out.println("=== PRESCRIPTION CREATION COMPLETED ===");

        return grandTotal;
    }


    /* ── queries ───────────────────────────────────────────── */
    public List<Prescription> getPrescriptionsByPatient(String userId) {
        return prescriptionRepo.findByPatientUserIdOrderByIdDesc(userId);
    }

    public List<Prescription> getAllPrescriptions() {
        return prescriptionRepo.findAllByOrderByIdDesc();
    }

    public List<Prescription> getPendingWithMedicines() {
        return prescriptionRepo.findDistinctByStatusOrderByIdDesc("PAYMENT_PENDING");
    }

    /* ── Medicine Inventory Methods ─────────────────────────────────────────── */

    public List<Medicine> getAllMedicinesWithInventoryInfo() {
        return medicineRepo.findAllByOrderByNameAsc();
    }

    public Map<String, Long> getMedicineCategoryCounts() {
        try {
            List<Object[]> categoryStats = medicineRepo.getCategoryCountStats();
            Map<String, Long> categoryCounts = new HashMap<>();

            for (Object[] stat : categoryStats) {
                String category = (String) stat[0];
                Long count = (Long) stat[1];
                categoryCounts.put(category, count);
            }

            // Add uncategorized count
            List<Medicine> uncategorized = medicineRepo.findUncategorizedMedicines();
            if (!uncategorized.isEmpty()) {
                categoryCounts.put("uncategorized", (long) uncategorized.size());
            }

            return categoryCounts;
        } catch (Exception ex) {
            // Fallback to manual grouping if the query method doesn't exist
            List<Medicine> medicines = medicineRepo.findAll();
            return medicines.stream()
                    .collect(Collectors.groupingBy(
                            medicine -> medicine.getCategory() != null ? medicine.getCategory() : "uncategorized",
                            Collectors.counting()
                    ));
        }
    }

    public List<String> getAllMedicineTypes() {
        return medicineRepo.findDistinctTypes();
    }

    public List<String> getAllCategories() {
        List<String> categories = medicineRepo.findDistinctCategories();
        // Add default categories if not present
        if (!categories.contains("tablet")) categories.add("tablet");
        if (!categories.contains("syrup")) categories.add("syrup");
        if (!categories.contains("injection")) categories.add("injection");
        if (!categories.contains("capsule")) categories.add("capsule");
        if (!categories.contains("cream")) categories.add("cream");
        if (!categories.contains("drops")) categories.add("drops");
        return categories.stream().sorted().collect(Collectors.toList());
    }

    public Medicine getMedicineById(Long id) {
        return medicineRepo.findById(id).orElse(null);
    }

    @Transactional
    public void updateMedicineCategory(Long medicineId, String category) {
        Medicine medicine = medicineRepo.findById(medicineId)
                .orElseThrow(() -> new RuntimeException("Medicine not found with ID: " + medicineId));

        // Validate category
        if (category == null || category.trim().isEmpty()) {
            throw new RuntimeException("Category cannot be empty");
        }

        String normalizedCategory = category.trim().toLowerCase();

        // Update the category
        medicine.setCategory(normalizedCategory);
        medicineRepo.save(medicine);

        // Log the update
        System.out.println("Updated medicine " + medicine.getName() + " category to: " + normalizedCategory);
    }

    @Transactional
    public int bulkUpdateMedicineCategory(List<Long> medicineIds, String category) {
        if (category == null || category.trim().isEmpty()) {
            throw new RuntimeException("Category cannot be empty");
        }

        String normalizedCategory = category.trim().toLowerCase();
        int updatedCount = 0;

        for (Long medicineId : medicineIds) {
            try {
                Medicine medicine = medicineRepo.findById(medicineId).orElse(null);
                if (medicine != null) {
                    medicine.setCategory(normalizedCategory);
                    medicineRepo.save(medicine);
                    updatedCount++;
                }
            } catch (Exception ex) {
                // Log error but continue with other medicines
                System.err.println("Failed to update medicine ID " + medicineId + ": " + ex.getMessage());
            }
        }

        return updatedCount;
    }

    public List<Medicine> searchMedicinesWithFilters(String query, String category, String type, String stockLevel) {
        try {
            // Try to use the advanced query method first
            return medicineRepo.findMedicinesWithAdvancedFilters(query, category, type, stockLevel);
        } catch (Exception ex) {
            // Fallback to manual filtering if the query method doesn't exist
            List<Medicine> medicines = medicineRepo.findAll();

            return medicines.stream()
                    .filter(medicine -> {
                        // Search filter
                        boolean matchesQuery = query == null || query.trim().isEmpty() ||
                                medicine.getName().toLowerCase().contains(query.toLowerCase()) ||
                                medicine.getCompany().toLowerCase().contains(query.toLowerCase()) ||
                                medicine.getType().toLowerCase().contains(query.toLowerCase());

                        // Category filter
                        boolean matchesCategory = category == null || category.trim().isEmpty() ||
                                (medicine.getCategory() != null && medicine.getCategory().equalsIgnoreCase(category));

                        // Type filter
                        boolean matchesType = type == null || type.trim().isEmpty() ||
                                medicine.getType().equalsIgnoreCase(type);

                        // Stock level filter
                        boolean matchesStockLevel = stockLevel == null || stockLevel.trim().isEmpty() ||
                                checkStockLevel(medicine, stockLevel);

                        return matchesQuery && matchesCategory && matchesType && matchesStockLevel;
                    })
                    .collect(Collectors.toList());
        }
    }

    private boolean checkStockLevel(Medicine medicine, String stockLevel) {
        int quantity = medicine.getQuantity();
        int minStock = medicine.getMinimumStock();

        switch (stockLevel.toLowerCase()) {
            case "high":
                return quantity > minStock * 2;
            case "medium":
                return quantity > minStock && quantity <= minStock * 2;
            case "low":
                return quantity > 0 && quantity <= minStock;
            case "out":
                return quantity <= 0;
            default:
                return true;
        }
    }

    public List<Medicine> getLowStockMedicines() {
        return medicineRepo.findLowStockMedicines();
    }

    public List<Medicine> getHighStockMedicines() {
        try {
            return medicineRepo.findHighStockMedicines();
        } catch (Exception ex) {
            // Fallback implementation
            return medicineRepo.findAll().stream()
                    .filter(m -> m.getQuantity() > m.getMinimumStock() * 2)
                    .collect(Collectors.toList());
        }
    }

    public List<Medicine> getMediumStockMedicines() {
        try {
            return medicineRepo.findMediumStockMedicines();
        } catch (Exception ex) {
            // Fallback implementation
            return medicineRepo.findAll().stream()
                    .filter(m -> m.getQuantity() > m.getMinimumStock() && m.getQuantity() <= m.getMinimumStock() * 2)
                    .collect(Collectors.toList());
        }
    }

    public List<Medicine> getOutOfStockMedicines() {
        try {
            return medicineRepo.findOutOfStockMedicines();
        } catch (Exception ex) {
            // Fallback implementation
            return medicineRepo.findAll().stream()
                    .filter(m -> m.getQuantity() <= 0)
                    .collect(Collectors.toList());
        }
    }

    public List<Medicine> getExpiringSoonMedicines(int days) {
        LocalDate cutoffDate = LocalDate.now().plusDays(days);
        return medicineRepo.findByExpiryDateBefore(cutoffDate);
    }

    public List<Medicine> getExpiredMedicines() {
        try {
            return medicineRepo.findExpiredMedicines();
        } catch (Exception ex) {
            // Fallback implementation
            return medicineRepo.findExpiringSoon(LocalDate.now());
        }
    }

    public Map<String, Object> getInventoryStatistics() {
        List<Medicine> allMedicines = medicineRepo.findAll();

        long totalMedicines = allMedicines.size();
        long lowStockCount = allMedicines.stream()
                .filter(m -> m.getQuantity() <= m.getMinimumStock())
                .count();
        long outOfStockCount = allMedicines.stream()
                .filter(m -> m.getQuantity() <= 0)
                .count();
        long expiredCount = getExpiredMedicines().size();
        long expiringSoonCount = getExpiringSoonMedicines(30).size();

        Double averagePrice = allMedicines.stream()
                .mapToDouble(Medicine::getPrice)
                .average()
                .orElse(0.0);

        Map<String, Long> categoryCounts = getMedicineCategoryCounts();
        Long totalCategories = (long) categoryCounts.size();

        return Map.of(
                "totalMedicines", totalMedicines,
                "lowStockCount", lowStockCount,
                "outOfStockCount", outOfStockCount,
                "expiredCount", expiredCount,
                "expiringSoonCount", expiringSoonCount,
                "averagePrice", averagePrice,
                "totalCategories", totalCategories,
                "categoryCounts", categoryCounts
        );
    }

    public Map<String, Object> getCategoryStatistics() {
        Map<String, Long> categoryCounts = getMedicineCategoryCounts();
        long totalMedicines = categoryCounts.values().stream().mapToLong(Long::longValue).sum();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalMedicines", totalMedicines);
        stats.put("totalCategories", categoryCounts.size());
        stats.put("categoryCounts", categoryCounts);

        // Find most and least populated categories
        if (!categoryCounts.isEmpty()) {
            String mostPopulatedCategory = categoryCounts.entrySet().stream()
                    .max(Map.Entry.comparingByValue())
                    .map(Map.Entry::getKey)
                    .orElse("N/A");

            String leastPopulatedCategory = categoryCounts.entrySet().stream()
                    .min(Map.Entry.comparingByValue())
                    .map(Map.Entry::getKey)
                    .orElse("N/A");

            stats.put("mostPopulatedCategory", mostPopulatedCategory);
            stats.put("leastPopulatedCategory", leastPopulatedCategory);
        }

        return stats;
    }

    public List<Medicine> getMedicinesByCategory(String category) {
        if (category == null || category.trim().isEmpty()) {
            return getAllMedicines();
        }
        return medicineRepo.findByCategoryIgnoreCase(category.trim());
    }

    public List<Medicine> getUncategorizedMedicines() {
        try {
            return medicineRepo.findUncategorizedMedicines();
        } catch (Exception ex) {
            // Fallback implementation
            return medicineRepo.findAll().stream()
                    .filter(m -> m.getCategory() == null || m.getCategory().trim().isEmpty() || m.getCategory().equalsIgnoreCase("uncategorized"))
                    .collect(Collectors.toList());
        }
    }

    public boolean isValidCategory(String category) {
        if (category == null || category.trim().isEmpty()) {
            return false;
        }

        String normalizedCategory = category.trim().toLowerCase();
        return normalizedCategory.matches("^[a-zA-Z0-9\\s]{1,50}$");
    }

    // Additional utility methods with fallbacks
    public List<Object[]> getInventoryReportByCategory() {
        try {
            return medicineRepo.getInventoryReportByCategory();
        } catch (Exception ex) {
            // Return empty list if method doesn't exist
            return List.of();
        }
    }

    public List<Object[]> getInventoryReportByType() {
        try {
            return medicineRepo.getInventoryReportByType();
        } catch (Exception ex) {
            // Return empty list if method doesn't exist
            return List.of();
        }
    }

    public List<Object[]> getInventoryReportByCompany() {
        try {
            return medicineRepo.getInventoryReportByCompany();
        } catch (Exception ex) {
            // Return empty list if method doesn't exist
            return List.of();
        }
    }

    public List<Medicine> searchMedicinesByTerm(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return getAllMedicines();
        }

        try {
            return medicineRepo.findMedicinesBySearchTerm(searchTerm.trim());
        } catch (Exception ex) {
            // Fallback to existing search method
            return searchMedicines(searchTerm.trim());
        }
    }

    public List<String> getAllCompanies() {
        try {
            return medicineRepo.findDistinctCompanies();
        } catch (Exception ex) {
            // Fallback implementation
            return medicineRepo.findAll().stream()
                    .map(Medicine::getCompany)
                    .filter(company -> company != null && !company.trim().isEmpty())
                    .distinct()
                    .sorted()
                    .collect(Collectors.toList());
        }
    }

    public List<Medicine> getMedicinesByPriceRange(Double minPrice, Double maxPrice) {
        try {
            return medicineRepo.findMedicinesByPriceRange(minPrice, maxPrice);
        } catch (Exception ex) {
            // Fallback implementation
            return medicineRepo.findAll().stream()
                    .filter(m -> m.getPrice() >= minPrice && m.getPrice() <= maxPrice)
                    .collect(Collectors.toList());
        }
    }

    public Double getAveragePriceByCategory(String category) {
        try {
            return medicineRepo.getAveragePriceByCategory(category);
        } catch (Exception ex) {
            // Fallback implementation
            return getMedicinesByCategory(category).stream()
                    .mapToDouble(Medicine::getPrice)
                    .average()
                    .orElse(0.0);
        }
    }

    /* ── Additional Prescription Methods for PharmacistService ────────────────── */

    // Get prescription by ID
    public Optional<Prescription> getPrescriptionById(Long id) {
        return prescriptionRepo.findById(id);
    }

    // Get pending prescriptions for a specific patient (for cashier dashboard)
    public List<Prescription> getPendingPrescriptionsByPatient(String patientUserId) {
        return prescriptionRepo.findByPatientUserIdAndStatus(patientUserId, "PAYMENT_PENDING");
    }

    // Save prescription
    @Transactional
    public Prescription savePrescription(Prescription prescription) {
        return prescriptionRepo.save(prescription);
    }

    // Update prescription status
    @Transactional
    public void updatePrescriptionStatus(Long prescriptionId, String status) {
        Optional<Prescription> prescriptionOpt = prescriptionRepo.findById(prescriptionId);
        if (prescriptionOpt.isPresent()) {
            Prescription prescription = prescriptionOpt.get();
            prescription.setStatus(status);
            prescriptionRepo.save(prescription);
        }
    }

    // Mark multiple prescriptions as completed/paid
    @Transactional
    public void markPrescriptionsAsCompleted(List<Long> prescriptionIds) {
        prescriptionIds.forEach(id -> updatePrescriptionStatus(id, "COMPLETED"));
    }

    // Delete prescription
    @Transactional
    public void deletePrescription(Long id) {
        prescriptionRepo.deleteById(id);
    }

    // Get prescriptions by status
    public List<Prescription> getPrescriptionsByStatus(String status) {
        return prescriptionRepo.findByStatus(status);
    }

    // Get pending prescriptions (payment pending)
    public List<Prescription> getPendingPrescriptions() {
        return prescriptionRepo.findByStatus("PAYMENT_PENDING");
    }

    // Get completed prescriptions
    public List<Prescription> getCompletedPrescriptions() {
        return prescriptionRepo.findByStatus("COMPLETED");
    }
}
