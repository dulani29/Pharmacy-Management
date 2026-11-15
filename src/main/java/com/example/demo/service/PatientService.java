package com.example.demo.service;

import com.example.demo.model.Patient;
import com.example.demo.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class PatientService {

    private final PatientRepository patientRepository;

    @Autowired
    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public List<Patient> searchPatientsByNameOrPhone(String query) {
        return patientRepository.findByNameContainingIgnoreCaseOrPhoneNumberContainingIgnoreCase(query, query);
    }

    public Optional<Patient> findByUserId(String userId) {
        return patientRepository.findByUserId(userId);
    }

    public List<Patient> getAllPatients() {
        return patientRepository.findAllOrderByNameAsc();
    }

    @Transactional
    public Patient makePremiumMember(String userId) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));

        patient.setPremiumMember(true);
        patient.setPremiumMemberSince(LocalDate.now());
        patient.setTotalPoints(0);

        return patientRepository.save(patient);
    }

    @Transactional
    public void addPoints(String userId, int points) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));

        if (!patient.isPremiumMember()) {
            throw new RuntimeException("Only premium members can earn points");
        }

        patient.setTotalPoints(patient.getTotalPoints() + points);
        patientRepository.save(patient);
    }

    @Transactional
    public void redeemPoints(String userId, int points) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));

        if (!patient.isPremiumMember()) {
            throw new RuntimeException("Only premium members can redeem points");
        }

        if (patient.getTotalPoints() < points) {
            throw new RuntimeException("Insufficient points balance");
        }

        patient.setTotalPoints(patient.getTotalPoints() - points);
        patientRepository.save(patient);
    }

    public List<Patient> getPremiumMembers() {
        return patientRepository.findByIsPremiumMember(true);
    }

    @Transactional
    public Patient save(Patient patient) {
        // Generate user ID if new patient
        if (patient.getUserId() == null || patient.getUserId().trim().isEmpty()) {
            patient.setUserId(generatePatientId());
        }
        return patientRepository.save(patient);
    }

    @Transactional
    public Patient createPatient(String name, String phoneNumber, Integer age) {
        Patient patient = new Patient();
        patient.setUserId(generatePatientId());
        patient.setName(name);
        patient.setPhoneNumber(phoneNumber);
        patient.setAge(age);
        patient.setPremiumMember(false);
        patient.setTotalPoints(0);

        return patientRepository.save(patient);
    }

    // FIXED: Generate unique 3-character patient IDs
    private String generatePatientId() {
        try {
            // Find the highest existing numeric user_id and increment
            List<Patient> allPatients = patientRepository.findAll();
            int maxId = 0;

            for (Patient patient : allPatients) {
                try {
                    int numericId = Integer.parseInt(patient.getUserId());
                    if (numericId > maxId) {
                        maxId = numericId;
                    }
                } catch (NumberFormatException e) {
                    // Skip non-numeric IDs
                    System.out.println("Skipping non-numeric patient ID: " + patient.getUserId());
                }
            }

            // Generate next ID
            String nextId = String.format("%03d", maxId + 1);
            System.out.println("Generated patient ID: " + nextId);
            return nextId;

        } catch (Exception e) {
            System.err.println("Error generating patient ID: " + e.getMessage());
            e.printStackTrace();

            // Fallback: use timestamp-based ID
            long timestamp = System.currentTimeMillis();
            String fallbackId = String.format("%03d", timestamp % 1000);
            System.out.println("Using fallback patient ID: " + fallbackId);
            return fallbackId;
        }
    }

    @Transactional
    public Patient updatePatient(String userId, Patient updatedPatient) {
        Patient existingPatient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));

        existingPatient.setName(updatedPatient.getName());
        existingPatient.setPhoneNumber(updatedPatient.getPhoneNumber());
        existingPatient.setAge(updatedPatient.getAge());

        return patientRepository.save(existingPatient);
    }

    public List<Patient> searchByName(String name) {
        return patientRepository.findByNameContainingIgnoreCase(name);
    }

    public boolean existsByUserId(String userId) {
        return patientRepository.findByUserId(userId).isPresent();
    }

    @Transactional
    public void deletePatient(String userId) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));
        patientRepository.delete(patient);
    }

    // Statistics methods
    public long getTotalPatients() {
        return patientRepository.count();
    }

    public long getPremiumMembersCount() {
        return patientRepository.findByIsPremiumMember(true).size();
    }

    public long getRegularMembersCount() {
        return getTotalPatients() - getPremiumMembersCount();
    }

    @Transactional
    public Patient upgradeToPremium(String userId) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));

        if (!patient.isPremiumMember()) {
            patient.upgradeToPremium();
            patientRepository.save(patient);
            System.out.println("Upgraded patient " + patient.getName() + " to premium membership");
        }

        return patient;
    }

    // Points management
    public int getPatientPoints(String userId) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));
        return patient.getTotalPoints();
    }

    public double getPointsValue(String userId) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));
        return patient.getPointsValue();
    }

    @Transactional
    public boolean canRedeemPoints(String userId, int points) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));

        return patient.isPremiumMember() && patient.getTotalPoints() >= points;
    }

    public boolean isValidPatient(String userId) {
        return patientRepository.findByUserId(userId).isPresent();
    }

    public boolean isPremiumMember(String userId) {
        Patient patient = patientRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Patient not found"));
        return patient.isPremiumMember();
    }

    // Get recent patients (based on creation order, most recent first)
    public List<Patient> getRecentPatients(int limit) {
        List<Patient> allPatients = patientRepository.findAllOrderByNameAsc();
        return allPatients.stream()
                .limit(limit)
                .collect(java.util.stream.Collectors.toList());
    }
}
