package com.example.demo.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id", referencedColumnName = "user_id", nullable = false)
    private Patient patient;

    @Column(nullable = false)
    private String paymentMethod;

    @Column(nullable = false)
    private String paymentStatus = "PENDING";

    @Column(nullable = false)
    private Double total;

    // New fields for premium membership system
    @Column(name = "original_total")
    private Double originalTotal;

    @Column(name = "points_used")
    private Integer pointsUsed = 0;

    @Column(name = "points_discount")
    private Double pointsDiscount = 0.0;

    @Column(name = "membership_fee")
    private Double membershipFee = 0.0;

    @Column(name = "points_earned")
    private Integer pointsEarned = 0;

    @Column(name = "payment_date")
    private LocalDateTime paymentDate;

    public Payment() {}

    public Payment(Patient patient, Double total) {
        this.patient = patient;
        this.total = total;
        this.originalTotal = total;
        this.paymentDate = LocalDateTime.now();
    }

    /* Getters and Setters */
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getOriginalTotal() {
        return originalTotal;
    }

    public void setOriginalTotal(Double originalTotal) {
        this.originalTotal = originalTotal;
    }

    public Integer getPointsUsed() {
        return pointsUsed != null ? pointsUsed : 0;
    }

    public void setPointsUsed(Integer pointsUsed) {
        this.pointsUsed = pointsUsed;
    }

    public Double getPointsDiscount() {
        return pointsDiscount != null ? pointsDiscount : 0.0;
    }

    public void setPointsDiscount(Double pointsDiscount) {
        this.pointsDiscount = pointsDiscount;
    }

    public Double getMembershipFee() {
        return membershipFee != null ? membershipFee : 0.0;
    }

    public void setMembershipFee(Double membershipFee) {
        this.membershipFee = membershipFee;
    }

    public Integer getPointsEarned() {
        return pointsEarned != null ? pointsEarned : 0;
    }

    public void setPointsEarned(Integer pointsEarned) {
        this.pointsEarned = pointsEarned;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    /* Utility Methods */
    public void calculateFinalTotal() {
        this.total = (getOriginalTotal() + getMembershipFee()) - getPointsDiscount();
        if (this.total < 0) {
            this.total = 0.0;
        }
    }

    public boolean isPaid() {
        return "PAID".equalsIgnoreCase(paymentStatus);
    }

    public boolean isPending() {
        return "PENDING".equalsIgnoreCase(paymentStatus);
    }

    @Override
    public String toString() {
        return "Payment{" +
                "id=" + id +
                ", patient=" + (patient != null ? patient.getName() : "null") +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", total=" + total +
                ", originalTotal=" + originalTotal +
                ", pointsUsed=" + pointsUsed +
                ", pointsDiscount=" + pointsDiscount +
                ", membershipFee=" + membershipFee +
                ", pointsEarned=" + pointsEarned +
                '}';
    }
}
