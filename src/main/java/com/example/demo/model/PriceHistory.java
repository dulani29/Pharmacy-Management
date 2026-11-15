package com.example.demo.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "price_history")
public class PriceHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "medicine_id", nullable = false)
    private Long medicineId;

    @Column(name = "old_price", nullable = false)
    private double oldPrice;

    @Column(name = "new_price", nullable = false)
    private double newPrice;

    @Column(name = "reason", length = 500)
    private String reason;

    @Column(name = "changed_at", nullable = false)
    private LocalDateTime changedAt;

    @Column(name = "changed_by", length = 100)
    private String changedBy;

    // Constructors
    public PriceHistory() {
        this.changedAt = LocalDateTime.now();
    }

    public PriceHistory(Long medicineId, double oldPrice, double newPrice, String reason, String changedBy) {
        this.medicineId = medicineId;
        this.oldPrice = oldPrice;
        this.newPrice = newPrice;
        this.reason = reason;
        this.changedBy = changedBy;
        this.changedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(Long medicineId) {
        this.medicineId = medicineId;
    }

    public double getOldPrice() {
        return oldPrice;
    }

    public void setOldPrice(double oldPrice) {
        this.oldPrice = oldPrice;
    }

    public double getNewPrice() {
        return newPrice;
    }

    public void setNewPrice(double newPrice) {
        this.newPrice = newPrice;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public LocalDateTime getChangedAt() {
        return changedAt;
    }

    public void setChangedAt(LocalDateTime changedAt) {
        this.changedAt = changedAt;
    }

    public String getChangedBy() {
        return changedBy;
    }

    public void setChangedBy(String changedBy) {
        this.changedBy = changedBy;
    }

    // Utility methods
    public double getPriceDifference() {
        return newPrice - oldPrice;
    }

    public double getPriceChangePercentage() {
        if (oldPrice == 0) return 0;
        return ((newPrice - oldPrice) / oldPrice) * 100;
    }

    @Override
    public String toString() {
        return "PriceHistory{" +
                "id=" + id +
                ", medicineId=" + medicineId +
                ", oldPrice=" + oldPrice +
                ", newPrice=" + newPrice +
                ", reason='" + reason + '\'' +
                ", changedAt=" + changedAt +
                ", changedBy='" + changedBy + '\'' +
                '}';
    }
}
