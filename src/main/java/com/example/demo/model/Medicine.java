package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "medicines")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Medicine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String type;

    @Column(nullable = false)
    private String category;  // NEW: Category field

    @Column(nullable = false)
    private String company;

    @Column(nullable = false)
    private double price;

    @Column(length = 500)
    private String description;

    @Column(name = "expiry_date", nullable = false)
    private LocalDate expiryDate;

    @Column(name = "last_restock_date")
    private LocalDateTime lastRestockDate;

    @Column(nullable = false)
    private int quantity;

    @Column(name = "minimum_stock", nullable = false)
    private int minimumStock = 10;

    // Constructors
    public Medicine() {
        this.lastRestockDate = LocalDateTime.now();
        this.category = "Uncategorized";
    }

    public Medicine(String name, String type, String category, String company, double price,
                    String description, LocalDate expiryDate, int quantity) {
        this.name = name;
        this.type = type;
        this.category = category != null ? category : "Uncategorized";
        this.company = company;
        this.price = price;
        this.description = description;
        this.expiryDate = expiryDate;
        this.quantity = quantity;
        this.lastRestockDate = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDate getExpiryDate() { return expiryDate; }
    public void setExpiryDate(LocalDate expiryDate) { this.expiryDate = expiryDate; }

    public LocalDateTime getLastRestockDate() { return lastRestockDate; }
    public void setLastRestockDate(LocalDateTime lastRestockDate) { this.lastRestockDate = lastRestockDate; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getMinimumStock() { return minimumStock; }
    public void setMinimumStock(int minimumStock) { this.minimumStock = minimumStock; }

    // Utility methods
    public void restock(int addQuantity) {
        this.quantity += addQuantity;
        this.lastRestockDate = LocalDateTime.now();
    }

    public boolean isLowStock() {
        return this.quantity <= this.minimumStock;
    }

    public boolean isExpired() {
        return this.expiryDate.isBefore(LocalDate.now());
    }

    @Override
    public String toString() {
        return "Medicine{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", category='" + category + '\'' +
                ", company='" + company + '\'' +
                ", quantity=" + quantity +
                '}';
    }
}
