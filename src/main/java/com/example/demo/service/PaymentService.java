package com.example.demo.service;

import com.example.demo.controller.PaymentController;
import com.example.demo.model.Patient;
import com.example.demo.model.Payment;
import com.example.demo.model.Prescription;
import com.example.demo.model.PointsTransaction;
import com.example.demo.repository.PaymentRepository;
import com.example.demo.repository.PatientRepository;
import com.example.demo.repository.PrescriptionRepository;
import com.example.demo.repository.PointsTransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PaymentService {

    private final PaymentRepository paymentRepository;
    private final PatientRepository patientRepository;
    private final PrescriptionRepository prescriptionRepository;
    private final PointsTransactionRepository pointsTransactionRepository;

    @Autowired
    public PaymentService(PaymentRepository paymentRepository,
                          PatientRepository patientRepository,
                          PrescriptionRepository prescriptionRepository,
                          PointsTransactionRepository pointsTransactionRepository) {
        this.paymentRepository = paymentRepository;
        this.patientRepository = patientRepository;
        this.prescriptionRepository = prescriptionRepository;
        this.pointsTransactionRepository = pointsTransactionRepository;
    }

    public List<Payment> searchByUserId(String userId) {
        return paymentRepository.findByPatientUserId(userId);
    }

    public List<Payment> searchByPatientName(String name) {
        return paymentRepository.findByPatientNameContainingIgnoreCase(name);
    }

    @Transactional
    public void markPaid(Long paymentId, String method, String status) {
        // This is a simpler payment method that just marks a payment as paid
        // without the complex points and membership logic
        Payment payment = paymentRepository.findById(paymentId)
                .orElseThrow(() -> new IllegalArgumentException("Payment not found"));

        payment.setPaymentMethod(method);
        payment.setPaymentStatus(status);
        payment.setPaymentDate(LocalDateTime.now());
        paymentRepository.save(payment);

        // Update prescription statuses
        String patientUserId = payment.getPatient().getUserId();
        List<Prescription> prescriptions = prescriptionRepository.findByPatientUserId(patientUserId);

        for (Prescription prescription : prescriptions) {
            if ("PENDING".equals(prescription.getStatus()) || "PAYMENT_PENDING".equals(prescription.getStatus())) {
                prescription.setStatus(status.equals("PAID") ? "COMPLETED" : status);
            }
        }
        prescriptionRepository.saveAll(prescriptions);
    }

    @Transactional
    public PaymentController.PaymentResult processPaymentWithMembership(
            String patientId,
            String paymentMethod,
            int pointsUsed,
            boolean addMembership,
            List<PaymentController.PrescriptionItemRequest> prescriptionItems) {

        PaymentController.PaymentResult result = new PaymentController.PaymentResult(false);

        try {
            System.out.println("Starting payment processing for patient: " + patientId);

            // Get patient
            Optional<Patient> patientOpt = patientRepository.findByUserId(patientId);
            if (patientOpt.isEmpty()) {
                result.setErrorMessage("Patient not found");
                return result;
            }

            Patient patient = patientOpt.get();
            System.out.println("Found patient: " + patient.getName() + ", Premium: " + patient.isPremiumMember());

            // Calculate totals
            double subtotal = prescriptionItems.stream()
                    .mapToDouble(item -> item.getQuantity() * item.getPrice())
                    .sum();

            System.out.println("Calculated subtotal: " + subtotal);

            // Handle membership upgrade
            double membershipFee = 0.0;
            if (addMembership && !patient.isPremiumMember()) {
                membershipFee = 500.0;
                patient.upgradeToPremium();
                patientRepository.save(patient);
                System.out.println("Upgraded patient to premium membership");
            }

            // Handle points redemption
            double pointsDiscount = 0.0;
            int adjustedPointsUsed = pointsUsed;
            if (adjustedPointsUsed > 0) {
                if (!patient.isPremiumMember()) {
                    result.setErrorMessage("Only premium members can use points");
                    return result;
                }

                int availablePoints = patient.getTotalPoints();

                // Enforce minimum balance of 50 points that must remain; minimum redeem is 1 point
                if (availablePoints <= 50) {
                    result.setErrorMessage("Insufficient points to redeem. Must keep a balance of 50 points.");
                    return result;
                }

                if (availablePoints < adjustedPointsUsed) {
                    result.setErrorMessage("Insufficient points. Available: " + availablePoints + ", Requested: " + adjustedPointsUsed);
                    return result;
                }

                // 1 point = 1 rupee, cap by payable amount (subtotal + membership)
                // and always keep 50 points balance unredeemed
                int payableAmount = (int) Math.floor(subtotal + membershipFee);
                int redeemableOverReserve = Math.max(0, availablePoints - 50);
                int maxRedeemable = Math.min(redeemableOverReserve, payableAmount);
                adjustedPointsUsed = Math.min(adjustedPointsUsed, maxRedeemable);

                pointsDiscount = adjustedPointsUsed; // 1 point = Rs.1
                patient.redeemPoints(adjustedPointsUsed);
                System.out.println("Redeemed " + adjustedPointsUsed + " points for Rs. " + pointsDiscount + " discount");
            }

            double finalTotal = Math.max(0, subtotal + membershipFee - pointsDiscount);

            // Calculate points earned: Rs.100 => 5 points (i.e., 5%) for premium members
            int pointsEarned = 0;
            if (patient.isPremiumMember()) {
                pointsEarned = (int) Math.floor(finalTotal * 0.05);
                if (pointsEarned > 0) {
                    patient.addPoints(pointsEarned);
                }
                System.out.println("Added " + pointsEarned + " points to patient account");
            }

            // Create payment record
            Payment payment = new Payment();
            payment.setPatient(patient);
            if (finalTotal == 0 && (paymentMethod == null || paymentMethod.isBlank())) {
                payment.setPaymentMethod("POINTS");
            } else {
                payment.setPaymentMethod(paymentMethod);
            }
            payment.setOriginalTotal(subtotal);
            payment.setMembershipFee(membershipFee);
            payment.setPointsUsed(adjustedPointsUsed);
            payment.setPointsDiscount(pointsDiscount);
            payment.setTotal(finalTotal);
            payment.setPointsEarned(pointsEarned);
            payment.setPaymentStatus("PAID");
            payment.setPaymentDate(LocalDateTime.now());

            Payment savedPayment = paymentRepository.save(payment);
            System.out.println("Created payment record with ID: " + savedPayment.getId());

            // Record points transactions (redeemed and earned)
            if (adjustedPointsUsed > 0) {
                PointsTransaction redeemedTxn = new PointsTransaction();
                redeemedTxn.setPatientUserId(patient.getUserId());
                redeemedTxn.setPoints(adjustedPointsUsed);
                redeemedTxn.setTransactionType("REDEEMED");
                redeemedTxn.setReferencePaymentId(savedPayment.getId());
                redeemedTxn.setDescription("Redeemed points for payment ID " + savedPayment.getId());
                pointsTransactionRepository.save(redeemedTxn);
            }

            if (pointsEarned > 0) {
                PointsTransaction earnedTxn = new PointsTransaction();
                earnedTxn.setPatientUserId(patient.getUserId());
                earnedTxn.setPoints(pointsEarned);
                earnedTxn.setTransactionType("EARNED");
                earnedTxn.setReferencePaymentId(savedPayment.getId());
                earnedTxn.setDescription("Points earned from payment ID " + savedPayment.getId());
                pointsTransactionRepository.save(earnedTxn);
            }

            // Update prescription statuses
            List<Long> prescriptionIds = prescriptionItems.stream()
                    .map(PaymentController.PrescriptionItemRequest::getPrescriptionId)
                    .filter(id -> id != null)
                    .collect(Collectors.toList());

            for (Long prescriptionId : prescriptionIds) {
                Optional<Prescription> prescriptionOpt = prescriptionRepository.findById(prescriptionId);
                if (prescriptionOpt.isPresent()) {
                    Prescription prescription = prescriptionOpt.get();
                    prescription.setStatus("COMPLETED");
                    prescriptionRepository.save(prescription);
                    System.out.println("Updated prescription " + prescriptionId + " to COMPLETED");
                }
            }

            // Save updated patient
            patientRepository.save(patient);

            // Success response
            result.setSuccess(true);
            result.setReceiptId("RCP-" + savedPayment.getId() + "-" + System.currentTimeMillis());
            result.setPointsEarned(pointsEarned);
            result.setFinalTotal(finalTotal);

            System.out.println("Payment processing completed successfully");

        } catch (Exception e) {
            System.err.println("Payment processing error: " + e.getMessage());
            e.printStackTrace();
            result.setErrorMessage("Payment processing failed: " + e.getMessage());
        }

        return result;
    }

    public Optional<Payment> findById(Long id) {
        return paymentRepository.findById(id);
    }

    public List<Payment> getAllPayments() {
        return paymentRepository.findAll();
    }

    public List<Payment> getPaidPayments() {
        return paymentRepository.findByPaymentStatus("PAID");
    }

    public List<Payment> getPendingPayments() {
        return paymentRepository.findByPaymentStatus("PENDING");
    }
}
