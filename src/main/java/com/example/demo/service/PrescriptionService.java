package com.example.demo.service;

import com.example.demo.model.Prescription;
import com.example.demo.repository.PrescriptionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class PrescriptionService {

    private final PrescriptionRepository prescriptionRepository;

    @Autowired
    public PrescriptionService(PrescriptionRepository prescriptionRepository) {
        this.prescriptionRepository = prescriptionRepository;
    }

    // Get all prescriptions
    public List<Prescription> getAllPrescriptions() {
        return prescriptionRepository.findAllByOrderByIdDesc();
    }

    // Get prescription by ID
    public Optional<Prescription> getPrescriptionById(Long id) {
        return prescriptionRepository.findById(id);
    }

    // Get pending prescriptions for a specific patient (for cashier dashboard)
    public List<Prescription> getPendingPrescriptionsByPatient(String patientUserId) {
        try {
            System.out.println("Getting pending prescriptions for patient: " + patientUserId);

            // Use the JOIN FETCH query to avoid lazy loading issues
            List<Prescription> prescriptions = prescriptionRepository.findByPatientUserIdAndStatusWithMedicine(patientUserId, "PAYMENT_PENDING");

            System.out.println("Found " + prescriptions.size() + " pending prescriptions with medicine details");

            // Log prescription details for debugging
            for (Prescription p : prescriptions) {
                System.out.println("Prescription ID: " + p.getId() +
                        ", Medicine: " + (p.getMedicine() != null ? p.getMedicine().getName() : "NULL") +
                        ", Qty: " + p.getQty() +
                        ", Status: " + p.getStatus());
            }

            return prescriptions;
        } catch (Exception e) {
            System.err.println("Error getting pending prescriptions: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // Get all prescriptions for a specific patient
    public List<Prescription> getPrescriptionsByPatient(String patientUserId) {
        return prescriptionRepository.findByPatientUserIdWithMedicine(patientUserId);
    }

    // Save prescription
    @Transactional
    public Prescription savePrescription(Prescription prescription) {
        return prescriptionRepository.save(prescription);
    }

    // Update prescription status
    @Transactional
    public void updatePrescriptionStatus(Long prescriptionId, String status) {
        Optional<Prescription> prescriptionOpt = prescriptionRepository.findById(prescriptionId);
        if (prescriptionOpt.isPresent()) {
            Prescription prescription = prescriptionOpt.get();
            prescription.setStatus(status);
            prescriptionRepository.save(prescription);
            System.out.println("Updated prescription " + prescriptionId + " status to: " + status);
        } else {
            System.err.println("Prescription not found with ID: " + prescriptionId);
        }
    }

    // Mark multiple prescriptions as completed/paid
    @Transactional
    public void markPrescriptionsAsCompleted(List<Long> prescriptionIds) {
        System.out.println("Marking " + prescriptionIds.size() + " prescriptions as completed");
        for (Long id : prescriptionIds) {
            updatePrescriptionStatus(id, "COMPLETED");
        }
    }

    // Delete prescription
    @Transactional
    public void deletePrescription(Long id) {
        prescriptionRepository.deleteById(id);
    }

    // Get prescriptions by status
    public List<Prescription> getPrescriptionsByStatus(String status) {
        return prescriptionRepository.findByStatus(status);
    }

    // Get pending prescriptions (payment pending)
    public List<Prescription> getPendingPrescriptions() {
        return prescriptionRepository.findByStatus("PAYMENT_PENDING");
    }

    // Get completed prescriptions
    public List<Prescription> getCompletedPrescriptions() {
        return prescriptionRepository.findByStatus("COMPLETED");
    }

    // Get prescriptions with medicine details (for better performance)
    public List<Prescription> getPendingPrescriptionsWithDetails() {
        return prescriptionRepository.findPendingPrescriptionsWithDetails();
    }

    // Update multiple prescriptions status
    @Transactional
    public void updateMultiplePrescriptionsStatus(List<Long> prescriptionIds, String status) {
        List<Prescription> prescriptions = prescriptionRepository.findByIdIn(prescriptionIds);
        prescriptions.forEach(prescription -> prescription.setStatus(status));
        prescriptionRepository.saveAll(prescriptions);
        System.out.println("Updated " + prescriptions.size() + " prescriptions to status: " + status);
    }

    // Get prescriptions count by status
    public long countPrescriptionsByStatus(String status) {
        return prescriptionRepository.countByStatus(status);
    }

    // Get prescriptions count by patient
    public long countPrescriptionsByPatient(String patientUserId) {
        return prescriptionRepository.countByPatientUserId(patientUserId);
    }

    // Find prescriptions by patient user ID (basic query without medicine fetch)
    public List<Prescription> findByPatientUserId(String patientUserId) {
        return prescriptionRepository.findByPatientUserId(patientUserId);
    }

    // Find prescriptions by patient user ID and status (basic query)
    public List<Prescription> findByPatientUserIdAndStatus(String patientUserId, String status) {
        return prescriptionRepository.findByPatientUserIdAndStatus(patientUserId, status);
    }

    // Create a new prescription
    @Transactional
    public Prescription createPrescription(Prescription prescription) {
        prescription.setStatus("PAYMENT_PENDING"); // Set default status
        return prescriptionRepository.save(prescription);
    }

    // Get prescription statistics
    public long getTotalPrescriptions() {
        return prescriptionRepository.count();
    }

    public long getPendingCount() {
        return countPrescriptionsByStatus("PAYMENT_PENDING");
    }

    public long getCompletedCount() {
        return countPrescriptionsByStatus("COMPLETED");
    }
}
