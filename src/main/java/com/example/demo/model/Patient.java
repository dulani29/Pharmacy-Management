package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "patients")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Patient {

    @Id
    @Column(name = "user_id", length = 20, nullable = false)
    private String userId;

    @Column(nullable = false, length = 100)
    private String name;

    private Integer age;

    @Column(name = "phone_number", length = 15)
    private String phoneNumber;

    @Column(name = "is_premium_member")
    private Boolean isPremiumMember = false;

    @Column(name = "premium_member_since")
    private LocalDate premiumMemberSince;

    @Column(name = "total_points")
    private Integer totalPoints = 0;

    // Default constructor
    public Patient() {}

    // Constructor with basic fields
    public Patient(String userId, String name, String phoneNumber) {
        this.userId = userId;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.isPremiumMember = false;
        this.totalPoints = 0;
    }

    // Constructor with all fields
    public Patient(String userId, String name, Integer age, String phoneNumber) {
        this.userId = userId;
        this.name = name;
        this.age = age;
        this.phoneNumber = phoneNumber;
        this.isPremiumMember = false;
        this.totalPoints = 0;
    }

    // Getters and Setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getPremiumMember() {
        return isPremiumMember;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Boolean isPremiumMember() {
        return isPremiumMember != null ? isPremiumMember : false;
    }

    public void setPremiumMember(Boolean premiumMember) {
        this.isPremiumMember = premiumMember;
    }

    public LocalDate getPremiumMemberSince() {
        return premiumMemberSince;
    }

    public void setPremiumMemberSince(LocalDate premiumMemberSince) {
        this.premiumMemberSince = premiumMemberSince;
    }

    public Integer getTotalPoints() {
        return totalPoints != null ? totalPoints : 0;
    }

    public void setTotalPoints(Integer totalPoints) {
        this.totalPoints = totalPoints;
    }

    // Utility methods
    public void addPoints(int points) {
        if (isPremiumMember()) {
            this.totalPoints = getTotalPoints() + points;
        }
    }

    public boolean redeemPoints(int points) {
        if (isPremiumMember() && getTotalPoints() >= points) {
            this.totalPoints = getTotalPoints() - points;
            return true;
        }
        return false;
    }

    public void upgradeToPremium() {
        this.isPremiumMember = true;
        this.premiumMemberSince = LocalDate.now();
        if (this.totalPoints == null) {
            this.totalPoints = 0;
        }
    }

    public double getPointsValue() {
        // 100 points = Rs. 3.50
        return getTotalPoints() * 0.035;
    }

    @Override
    public String toString() {
        return "Patient{" +
                "userId='" + userId + '\'' +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", isPremiumMember=" + isPremiumMember +
                ", totalPoints=" + totalPoints +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Patient patient = (Patient) o;
        return userId != null && userId.equals(patient.userId);
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }
}
