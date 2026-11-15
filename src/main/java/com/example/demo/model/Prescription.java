package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;

@Entity
@Table(name = "prescriptions")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Prescription {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // FIXED: Correct mapping to match your database - patient_id column
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", referencedColumnName = "user_id", nullable = false)
    @JsonIgnoreProperties({"prescriptions"})
    private Patient patient;

    // Medicine relationship
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medicine_id", nullable = false)
    private Medicine medicine;

    @Column
    private String status = "PAYMENT_PENDING";

    @Column(nullable = false)
    private Integer qty = 1;

    /* Constructors */
    public Prescription() {}

    public Prescription(Patient patient, Medicine medicine, Integer qty) {
        this.patient = patient;
        this.medicine = medicine;
        this.qty = qty;
        this.status = "PAYMENT_PENDING";
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

    public Medicine getMedicine() {
        return medicine;
    }

    public void setMedicine(Medicine medicine) {
        this.medicine = medicine;
    }

    public String getStatus() {
        return status != null ? status : "PAYMENT_PENDING";
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getQty() {
        return qty != null ? qty : 1;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    /* Utility Methods */
    public double getTotalPrice() {
        return medicine != null ? medicine.getPrice() * getQty() : 0.0;
    }

    public boolean isPending() {
        return "PAYMENT_PENDING".equalsIgnoreCase(getStatus());
    }

    public boolean isCompleted() {
        return "COMPLETED".equalsIgnoreCase(getStatus());
    }

    public boolean isCancelled() {
        return "CANCELLED".equalsIgnoreCase(getStatus());
    }

    public String getFormattedPrice() {
        return String.format("Rs. %.2f", getTotalPrice());
    }

    public String getStatusDisplayName() {
        String currentStatus = getStatus();
        switch (currentStatus.toUpperCase()) {
            case "PAYMENT_PENDING":
                return "Payment Pending";
            case "COMPLETED":
                return "Completed";
            case "CANCELLED":
                return "Cancelled";
            default:
                return currentStatus;
        }
    }

    @Override
    public String toString() {
        return "Prescription{" +
                "id=" + id +
                ", patient=" + (patient != null ? patient.getName() : "null") +
                ", medicine=" + (medicine != null ? medicine.getName() : "null") +
                ", status='" + getStatus() + '\'' +
                ", qty=" + getQty() +
                ", totalPrice=" + getTotalPrice() +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Prescription that = (Prescription) o;
        return id != null && id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}
