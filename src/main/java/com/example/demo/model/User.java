package com.example.demo.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(nullable = false)
    private String password;


    @Column(nullable = false)
    private String role = "USER"; // Changed from 'Role' to 'role'

    private Integer age;
    private String gender;
    private String phone;
    private String address;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @Column(name = "last_login")
    private LocalDateTime lastLogin;

    // Constructors
    public User() {
        this.createdAt = LocalDateTime.now();
        this.isActive = true;
    }

    public User(String username, String password, String role, String firstName, String lastName) {
        this();
        this.username = username;
        this.password = password;
        this.role = role; // Changed from 'Role' to 'role'
        this.firstName = firstName;
        this.lastName = lastName;
    }

    // Getters and Setters - IMPORTANT: Fix these method names
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // Fixed getter/setter names
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }

    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }

    // HomeController compatibility methods
    public boolean isActive() {
        return isActive != null ? isActive : false;
    }

    public void setActive(boolean active) {
        this.isActive = active;
    }

    // Utility methods
    public String getFullName() {
        if (firstName != null && lastName != null) {
            return firstName + " " + lastName;
        } else if (firstName != null) {
            return firstName;
        } else if (lastName != null) {
            return lastName;
        } else {
            return username;
        }
    }



    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(role) || "admin".equalsIgnoreCase(role);
    }

    public boolean isPharmacist() {
        return "PHARMACIST".equalsIgnoreCase(role) || "pharmacist".equalsIgnoreCase(role);
    }

    public boolean isCashier() {
        return "CASHIER".equalsIgnoreCase(role) || "cashier".equalsIgnoreCase(role);
    }

    public boolean isInventoryManager() {
        return "INVENTORY".equalsIgnoreCase(role) || "inventory".equalsIgnoreCase(role);
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", role='" + role + '\'' +
                ", fullName='" + getFullName() + '\'' +
                ", email='" + email + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}
