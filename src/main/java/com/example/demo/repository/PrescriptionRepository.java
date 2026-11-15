package com.example.demo.repository;

import com.example.demo.model.Prescription;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {

    // FIXED: Updated to use patient_id column
    @Query("SELECT p FROM Prescription p WHERE p.patient.userId = :patientUserId")
    List<Prescription> findByPatientUserId(@Param("patientUserId") String patientUserId);

    // Find prescriptions by patient user ID and status
    @Query("SELECT p FROM Prescription p WHERE p.patient.userId = :patientUserId AND p.status = :status")
    List<Prescription> findByPatientUserIdAndStatus(@Param("patientUserId") String patientUserId, @Param("status") String status);

    // Find prescriptions by status
    List<Prescription> findByStatus(String status);

    // Find prescriptions by ID list
    List<Prescription> findByIdIn(List<Long> ids);

    @Query("SELECT DISTINCT p FROM Prescription p WHERE p.status = :status ORDER BY p.id DESC")
    List<Prescription> findDistinctByStatusOrderByIdDesc(@Param("status") String status);

    @Query("SELECT p FROM Prescription p ORDER BY p.id DESC")
    List<Prescription> findAllByOrderByIdDesc();

    @Query("SELECT p FROM Prescription p WHERE p.patient.userId = :userId ORDER BY p.id DESC")
    List<Prescription> findByPatientUserIdOrderByIdDesc(@Param("userId") String userId);

    // FIXED: Updated JOIN FETCH queries for correct mapping
    @Query("SELECT p FROM Prescription p JOIN FETCH p.medicine JOIN FETCH p.patient WHERE p.patient.userId = :patientUserId")
    List<Prescription> findByPatientUserIdWithMedicine(@Param("patientUserId") String patientUserId);

    // FIXED: Key query for cashier dashboard with correct mapping
    @Query("SELECT p FROM Prescription p JOIN FETCH p.medicine JOIN FETCH p.patient WHERE p.patient.userId = :patientUserId AND p.status = :status")
    List<Prescription> findByPatientUserIdAndStatusWithMedicine(@Param("patientUserId") String patientUserId, @Param("status") String status);

    // Find all pending prescriptions with details
    @Query("SELECT p FROM Prescription p JOIN FETCH p.medicine JOIN FETCH p.patient WHERE p.status = 'PAYMENT_PENDING'")
    List<Prescription> findPendingPrescriptionsWithDetails();

    // Count methods
    long countByStatus(String status);

    @Query("SELECT COUNT(p) FROM Prescription p WHERE p.patient.userId = :patientUserId")
    long countByPatientUserId(@Param("patientUserId") String patientUserId);

    @Transactional
    void deleteByPatientUserId(String patientUserId);
}
