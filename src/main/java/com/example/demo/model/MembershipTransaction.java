package com.example.demo.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "membership_transactions")
public class MembershipTransaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "patient_user_id", nullable = false, length = 3)
    private String patientUserId;

    @Column(name = "transaction_date")
    private LocalDateTime transactionDate;

    @Column(nullable = false)
    private Double amount;

    @Column(name = "transaction_type", nullable = false)
    private String transactionType = "MEMBERSHIP_FEE";

    private String description;

    public MembershipTransaction() {
        this.transactionDate = LocalDateTime.now();
    }

    public MembershipTransaction(String patientUserId, Double amount, String description) {
        this();
        this.patientUserId = patientUserId;
        this.amount = amount;
        this.description = description;
    }

    /* Getters and Setters */
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getPatientUserId() { return patientUserId; }
    public void setPatientUserId(String patientUserId) { this.patientUserId = patientUserId; }

    public LocalDateTime getTransactionDate() { return transactionDate; }
    public void setTransactionDate(LocalDateTime transactionDate) { this.transactionDate = transactionDate; }

    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }

    public String getTransactionType() { return transactionType; }
    public void setTransactionType(String transactionType) { this.transactionType = transactionType; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
