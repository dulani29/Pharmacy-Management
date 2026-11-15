package com.example.demo.repository;

import com.example.demo.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {

    // FIXED: Updated to use correct column mapping
    @Query("SELECT p FROM Payment p WHERE p.patient.userId = :userId")
    List<Payment> findByPatientUserId(@Param("userId") String userId);

    // Find payments by patient name (case insensitive)
    @Query("SELECT p FROM Payment p WHERE LOWER(p.patient.name) LIKE LOWER(CONCAT('%', :name, '%'))")
    List<Payment> findByPatientNameContainingIgnoreCase(@Param("name") String name);

    // Find payments by status
    @Query("SELECT p FROM Payment p WHERE p.paymentStatus = :status")
    List<Payment> findByPaymentStatus(@Param("status") String status);

    // Find all paid payments
    @Query("SELECT p FROM Payment p WHERE p.paymentStatus = 'PAID' ORDER BY p.paymentDate DESC")
    List<Payment> findAllPaidPayments();

    // Find all pending payments
    @Query("SELECT p FROM Payment p WHERE p.paymentStatus = 'PENDING' ORDER BY p.paymentDate DESC")
    List<Payment> findAllPendingPayments();

    // Get payment statistics
    @Query("SELECT COUNT(p) FROM Payment p WHERE p.paymentStatus = 'PAID'")
    long countPaidPayments();

    @Query("SELECT COUNT(p) FROM Payment p WHERE p.paymentStatus = 'PENDING'")
    long countPendingPayments();

    @Query("SELECT SUM(p.total) FROM Payment p WHERE p.paymentStatus = 'PAID'")
    Double getTotalRevenue();

    // Find payments with membership fee
    @Query("SELECT p FROM Payment p WHERE p.membershipFee > 0")
    List<Payment> findPaymentsWithMembershipFee();

    // Find payments where points were used
    @Query("SELECT p FROM Payment p WHERE p.pointsUsed > 0")
    List<Payment> findPaymentsWithPointsUsed();

    @Transactional
    void deleteByPatientUserId(String userId);
}
