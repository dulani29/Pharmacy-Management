package com.example.demo.controller;

import com.example.demo.model.Patient;
import com.example.demo.model.Payment;
import com.example.demo.model.Prescription;
import com.example.demo.repository.PaymentRepository;
import com.example.demo.service.PaymentService;
import com.example.demo.service.PatientService;
import com.example.demo.service.PrescriptionService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/cashier")
public class PaymentController {

    private final PaymentService paymentService;
    private final PatientService patientService;
    private final PrescriptionService prescriptionService;

    @Autowired
    public PaymentController(PaymentService paymentService,
                             PatientService patientService,
                             PrescriptionService prescriptionService) {
        this.paymentService = paymentService;
        this.patientService = patientService;
        this.prescriptionService = prescriptionService;
    }

    /* ── dashboard ───────────────────────────────────────────── */
    @GetMapping("/dashboard")
    public String dashboard() {
        return "cashier-dashboard";
    }

    /* ── search patients by name or phone number ────────────────── */
    /* ── search patients by name or phone number - ENHANCED ────────────────── */
    @GetMapping("/search")
    public String search(@RequestParam(required = false) String query,
                         @RequestParam(required = false) String selectedPatientId,
                         Model model) {
        List<Patient> patients;

        if (query != null && !query.trim().isEmpty()) {
            try {
                patients = patientService.searchPatientsByNameOrPhone(query.trim());
                model.addAttribute("query", query.trim());
                System.out.println("Patient search for '" + query.trim() + "' returned " + patients.size() + " results");

                // Debug: Log each patient found
                for (Patient p : patients) {
                    System.out.println("Found patient: " + p.getName() + " - Phone: " + p.getPhoneNumber() + " - ID: " + p.getUserId());
                }

            } catch (Exception e) {
                System.err.println("Error searching patients: " + e.getMessage());
                e.printStackTrace();
                patients = List.of();
                model.addAttribute("searchError", "Error searching patients: " + e.getMessage());
            }
        } else {
            patients = List.of();
            model.addAttribute("query", "");
        }

        model.addAttribute("patients", patients);

        // ENHANCED: Preserve selected patient ID if provided
        if (selectedPatientId != null && !selectedPatientId.trim().isEmpty()) {
            model.addAttribute("selectedPatientId", selectedPatientId.trim());
            System.out.println("Preserving selected patient ID: " + selectedPatientId.trim());
        }

        return "cashier-dashboard";
    }

    /* ── get prescriptions for a specific patient (AJAX endpoint) ────── */
    @GetMapping("/prescriptions/{patientUserId}")
    @ResponseBody
    public ResponseEntity<?> getPatientPrescriptions(@PathVariable String patientUserId) {
        try {
            System.out.println("API call - Loading prescriptions for patient: " + patientUserId);

            // Verify patient exists
            Optional<Patient> patientOpt = patientService.findByUserId(patientUserId);
            if (patientOpt.isEmpty()) {
                System.err.println("Patient not found: " + patientUserId);
                return ResponseEntity.notFound().build();
            }

            // Get pending prescriptions for this patient with medicine details
            List<Prescription> prescriptions = prescriptionService.getPendingPrescriptionsByPatient(patientUserId);

            System.out.println("API response - Found " + prescriptions.size() + " pending prescriptions");

            // Convert to DTOs to avoid JSON serialization issues
            List<PrescriptionDTO> prescriptionDTOs = prescriptions.stream()
                    .map(this::convertToPrescriptionDTO)
                    .collect(Collectors.toList());

            System.out.println("Converted to " + prescriptionDTOs.size() + " DTOs");

            // Log the DTO data for debugging
            for (PrescriptionDTO dto : prescriptionDTOs) {
                System.out.println("DTO: " + dto.getId() + ", Medicine: " +
                        (dto.getMedicine() != null ? dto.getMedicine().getName() : "NULL") +
                        ", Qty: " + dto.getQty());
            }

            return ResponseEntity.ok(prescriptionDTOs);
        } catch (Exception e) {
            System.err.println("API error loading prescriptions: " + e.getMessage());
            e.printStackTrace();

            // Return error response with details
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "Failed to load prescriptions");
            errorResponse.put("message", e.getMessage());
            errorResponse.put("patientId", patientUserId);

            return ResponseEntity.internalServerError().body(errorResponse);
        }
    }

    /* ── Helper method to convert Prescription to DTO ────────────────── */
    private PrescriptionDTO convertToPrescriptionDTO(Prescription prescription) {
        PrescriptionDTO dto = new PrescriptionDTO();
        dto.setId(prescription.getId());
        dto.setQty(prescription.getQty());
        dto.setStatus(prescription.getStatus());

        // Convert medicine to DTO
        if (prescription.getMedicine() != null) {
            MedicineDTO medicineDTO = new MedicineDTO();
            medicineDTO.setId(prescription.getMedicine().getId());
            medicineDTO.setName(prescription.getMedicine().getName());
            medicineDTO.setPrice(prescription.getMedicine().getPrice());
            medicineDTO.setType(prescription.getMedicine().getType());
            medicineDTO.setCompany(prescription.getMedicine().getCompany());
            medicineDTO.setCategory(prescription.getMedicine().getCategory());
            dto.setMedicine(medicineDTO);
        }

        return dto;
    }

    /* ── debug endpoint for troubleshooting ────────────────────── */
    @GetMapping("/debug/prescriptions/{patientUserId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> debugPrescriptions(@PathVariable String patientUserId) {
        Map<String, Object> debug = new HashMap<>();

        try {
            // Check if patient exists
            Optional<Patient> patient = patientService.findByUserId(patientUserId);
            debug.put("patientExists", patient.isPresent());
            if (patient.isPresent()) {
                debug.put("patientName", patient.get().getName());
                debug.put("patientPremium", patient.get().isPremiumMember());
                debug.put("patientPoints", patient.get().getTotalPoints());
            }

            // Get all prescriptions for this patient
            List<Prescription> allPrescriptions = prescriptionService.getPrescriptionsByPatient(patientUserId);
            debug.put("totalPrescriptions", allPrescriptions.size());

            // Get pending prescriptions
            List<Prescription> pendingPrescriptions = prescriptionService.getPendingPrescriptionsByPatient(patientUserId);
            debug.put("pendingPrescriptions", pendingPrescriptions.size());

            // Get prescription details
            debug.put("prescriptionDetails", pendingPrescriptions.stream().map(p -> {
                Map<String, Object> details = new HashMap<>();
                details.put("id", p.getId());
                details.put("status", p.getStatus());
                details.put("qty", p.getQty());
                if (p.getMedicine() != null) {
                    details.put("medicineName", p.getMedicine().getName());
                    details.put("medicinePrice", p.getMedicine().getPrice());
                    details.put("medicineType", p.getMedicine().getType());
                    details.put("medicineCompany", p.getMedicine().getCompany());
                    details.put("medicineCategory", p.getMedicine().getCategory());
                } else {
                    details.put("medicineError", "Medicine is null");
                }
                return details;
            }).collect(Collectors.toList()));

            return ResponseEntity.ok(debug);

        } catch (Exception e) {
            debug.put("error", e.getMessage());
            debug.put("errorType", e.getClass().getSimpleName());
            return ResponseEntity.ok(debug);
        }
    }

    /* ── process payment with premium membership and points ────────── */
    @PostMapping("/process-payment")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> processPayment(@RequestBody PaymentRequest paymentRequest) {
        Map<String, Object> response = new HashMap<>();

        try {
            System.out.println("Processing payment for patient: " + paymentRequest.getPatientId());

            // Validate request
            if (paymentRequest.getPatientId() == null || paymentRequest.getPatientId().trim().isEmpty()) {
                response.put("success", false);
                response.put("message", "Patient ID is required");
                return ResponseEntity.badRequest().body(response);
            }

            if (paymentRequest.getPaymentMethod() == null || paymentRequest.getPaymentMethod().trim().isEmpty()) {
                response.put("success", false);
                response.put("message", "Payment method is required");
                return ResponseEntity.badRequest().body(response);
            }

            if (paymentRequest.getPrescriptionItems() == null || paymentRequest.getPrescriptionItems().isEmpty()) {
                response.put("success", false);
                response.put("message", "No prescription items found");
                return ResponseEntity.badRequest().body(response);
            }

            // Process the payment with premium membership and points
            PaymentResult result = paymentService.processPaymentWithMembership(
                    paymentRequest.getPatientId(),
                    paymentRequest.getPaymentMethod(),
                    paymentRequest.getPointsUsed(),
                    paymentRequest.isAddMembership(),
                    paymentRequest.getPrescriptionItems()
            );

            if (result.isSuccess()) {
                response.put("success", true);
                response.put("receiptId", result.getReceiptId());
                response.put("pointsEarned", result.getPointsEarned());
                response.put("pointsUsed", paymentRequest.getPointsUsed());
                response.put("finalTotal", result.getFinalTotal());
                response.put("message", "Payment processed successfully");

                System.out.println("Payment processed successfully for patient: " + paymentRequest.getPatientId());
            } else {
                response.put("success", false);
                response.put("message", result.getErrorMessage());
                System.err.println("Payment failed: " + result.getErrorMessage());
            }

        } catch (Exception e) {
            System.err.println("Payment processing error: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Payment processing failed: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /* ── logout functionality ────────────────────────────────────── */
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        redirectAttributes.addFlashAttribute("success", "You have been logged out successfully");
        return "redirect:/login";
    }

    /* ── DTOs for JSON serialization ────────────────────────────── */
    public static class PrescriptionDTO {
        private Long id;
        private Integer qty;
        private String status;
        private MedicineDTO medicine;

        // Getters and setters
        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }

        public Integer getQty() { return qty; }
        public void setQty(Integer qty) { this.qty = qty; }

        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }

        public MedicineDTO getMedicine() { return medicine; }
        public void setMedicine(MedicineDTO medicine) { this.medicine = medicine; }
    }

    public static class MedicineDTO {
        private Long id;
        private String name;
        private double price;
        private String type;
        private String company;
        private String category;

        // Getters and setters
        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public double getPrice() { return price; }
        public void setPrice(double price) { this.price = price; }

        public String getType() { return type; }
        public void setType(String type) { this.type = type; }

        public String getCompany() { return company; }
        public void setCompany(String company) { this.company = company; }

        public String getCategory() { return category; }
        public void setCategory(String category) { this.category = category; }
    }

    /* ── DTOs for payment processing ────────────────────────────── */
    public static class PaymentRequest {
        private String patientId;
        private String paymentMethod;
        private int pointsUsed;
        private boolean addMembership;
        private double subtotal;
        private double membershipFee;
        private double pointsDiscount;
        private double finalTotal;
        private List<PrescriptionItemRequest> prescriptionItems;

        // Getters and setters
        public String getPatientId() { return patientId; }
        public void setPatientId(String patientId) { this.patientId = patientId; }

        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

        public int getPointsUsed() { return pointsUsed; }
        public void setPointsUsed(int pointsUsed) { this.pointsUsed = pointsUsed; }

        public boolean isAddMembership() { return addMembership; }
        public void setAddMembership(boolean addMembership) { this.addMembership = addMembership; }

        public double getSubtotal() { return subtotal; }
        public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

        public double getMembershipFee() { return membershipFee; }
        public void setMembershipFee(double membershipFee) { this.membershipFee = membershipFee; }

        public double getPointsDiscount() { return pointsDiscount; }
        public void setPointsDiscount(double pointsDiscount) { this.pointsDiscount = pointsDiscount; }

        public double getFinalTotal() { return finalTotal; }
        public void setFinalTotal(double finalTotal) { this.finalTotal = finalTotal; }

        public List<PrescriptionItemRequest> getPrescriptionItems() { return prescriptionItems; }
        public void setPrescriptionItems(List<PrescriptionItemRequest> prescriptionItems) {
            this.prescriptionItems = prescriptionItems;
        }
    }

    public static class PrescriptionItemRequest {
        private Long prescriptionId;
        private Long medicineId;
        private int quantity;
        private double price;

        // Getters and setters
        public Long getPrescriptionId() { return prescriptionId; }
        public void setPrescriptionId(Long prescriptionId) { this.prescriptionId = prescriptionId; }

        public Long getMedicineId() { return medicineId; }
        public void setMedicineId(Long medicineId) { this.medicineId = medicineId; }

        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }

        public double getPrice() { return price; }
        public void setPrice(double price) { this.price = price; }
    }

    public static class PaymentResult {
        private boolean success;
        private String receiptId;
        private int pointsEarned;
        private double finalTotal;
        private String errorMessage;

        public PaymentResult(boolean success) {
            this.success = success;
        }

        // Getters and setters
        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }

        public String getReceiptId() { return receiptId; }
        public void setReceiptId(String receiptId) { this.receiptId = receiptId; }

        public int getPointsEarned() { return pointsEarned; }
        public void setPointsEarned(int pointsEarned) { this.pointsEarned = pointsEarned; }

        public double getFinalTotal() { return finalTotal; }
        public void setFinalTotal(double finalTotal) { this.finalTotal = finalTotal; }

        public String getErrorMessage() { return errorMessage; }
        public void setErrorMessage(String errorMessage) { this.errorMessage = errorMessage; }
    }
}
