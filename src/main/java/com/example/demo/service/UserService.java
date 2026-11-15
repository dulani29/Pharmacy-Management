package com.example.demo.service;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Authentication methods
    public User authenticateUser(String username, String password, String role) {
        try {
            User user = userRepository.findByUsername(username);

            if (user != null &&
                    user.getPassword().equals(password) &&
                    user.getRole().equalsIgnoreCase(role) &&
                    user.isActive()) {
                return user;
            }

            return null;
        } catch (Exception e) {
            System.err.println("Authentication error: " + e.getMessage());
            return null;
        }
    }

    public void updateLastLogin(Long userId) {
        try {
            Optional<User> userOpt = userRepository.findById(userId);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                user.setLastLogin(LocalDateTime.now());
                userRepository.save(user);
            }
        } catch (Exception e) {
            System.err.println("Error updating last login: " + e.getMessage());
        }
    }

    public boolean sendPasswordResetEmail(String username) {
        try {
            User user = userRepository.findByUsername(username);
            if (user != null && user.getEmail() != null) {
                // TODO: Implement actual email sending logic
                System.out.println("Password reset email would be sent to: " + user.getEmail());
                System.out.println("Reset link for user: " + username);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error sending password reset email: " + e.getMessage());
            return false;
        }
    }

    // ✅ FIXED: Dashboard data methods using correct repository method names
    public Map<String, Object> getAdminDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        try {
            stats.put("totalUsers", userRepository.count());
            stats.put("activeUsers", userRepository.countActiveUsers()); // ✅ FIXED
            stats.put("totalAdmins", userRepository.countByRole("admin"));
            stats.put("totalPharmacists", userRepository.countByRole("pharmacist"));
            stats.put("totalCashiers", userRepository.countByRole("cashier"));
            stats.put("totalInventoryManagers", userRepository.countByRole("inventory"));

            // ✅ FIXED: Additional stats with correct method names
            stats.put("activePharmacists", userRepository.countActiveUsersByRole("pharmacist"));
            stats.put("activeCashiers", userRepository.countActiveUsersByRole("cashier"));
            stats.put("activeInventoryManagers", userRepository.countActiveUsersByRole("inventory"));

        } catch (Exception e) {
            System.err.println("Error getting admin dashboard stats: " + e.getMessage());
        }
        return stats;
    }

    public List<Object> getPendingPrescriptions() {
        // TODO: Implement prescription logic when you have prescription entities
        List<Object> prescriptions = new ArrayList<>();

        // Mock data for now
        Map<String, Object> prescription1 = new HashMap<>();
        prescription1.put("id", 1);
        prescription1.put("patientName", "John Patient");
        prescription1.put("doctorName", "Dr. Smith");
        prescription1.put("status", "Pending");
        prescription1.put("date", LocalDateTime.now());
        prescriptions.add(prescription1);

        Map<String, Object> prescription2 = new HashMap<>();
        prescription2.put("id", 2);
        prescription2.put("patientName", "Jane Doe");
        prescription2.put("doctorName", "Dr. Johnson");
        prescription2.put("status", "In Progress");
        prescription2.put("date", LocalDateTime.now().minusHours(2));
        prescriptions.add(prescription2);

        return prescriptions;
    }

    public List<Object> getLowStockItems() {
        // TODO: Implement inventory logic when you have inventory entities
        List<Object> lowStockItems = new ArrayList<>();

        // Mock data for now
        Map<String, Object> item1 = new HashMap<>();
        item1.put("id", 1);
        item1.put("medicineName", "Paracetamol");
        item1.put("currentStock", 15);
        item1.put("minimumStock", 50);
        item1.put("status", "Low Stock");
        lowStockItems.add(item1);

        Map<String, Object> item2 = new HashMap<>();
        item2.put("id", 2);
        item2.put("medicineName", "Ibuprofen");
        item2.put("currentStock", 8);
        item2.put("minimumStock", 25);
        item2.put("status", "Critical Stock");
        lowStockItems.add(item2);

        return lowStockItems;
    }

    public Map<String, Object> getTodaySales() {
        Map<String, Object> sales = new HashMap<>();

        // TODO: Implement actual sales logic when you have sales entities
        // Mock data for now
        sales.put("totalSales", 2500.75);
        sales.put("transactionCount", 45);
        sales.put("averageTransaction", 55.57);
        sales.put("date", LocalDateTime.now().toLocalDate());
        sales.put("topSellingMedicine", "Paracetamol");
        sales.put("totalCustomers", 38);

        return sales;
    }

    // User management methods
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public User saveUser(User user) {
        if (user.getCreatedAt() == null) {
            user.setCreatedAt(LocalDateTime.now());
        }
        return userRepository.save(user);
    }

    public List<User> findAllUsers() {
        return userRepository.findAll();
    }

    public long getTotalUsers() {
        return userRepository.count();
    }

    // ✅ FIXED: Using correct method name
    public long getActiveUsers() {
        return userRepository.countActiveUsers();
    }

    public User findById(Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.orElse(null);
    }

    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    public List<User> findUsersByRole(String role) {
        return userRepository.findByRole(role);
    }

    public boolean isUsernameExists(String username) {
        return userRepository.findByUsername(username) != null;
    }

    public boolean isEmailExists(String email) {
        return userRepository.findByEmail(email) != null;
    }

    // Additional utility methods
    public User createUser(String firstName, String lastName, String email,
                           String username, String password, String role) {
        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);
        user.setActive(true);
        user.setCreatedAt(LocalDateTime.now());

        return userRepository.save(user);
    }

    public boolean deactivateUser(Long userId) {
        try {
            Optional<User> userOpt = userRepository.findById(userId);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                user.setActive(false);
                userRepository.save(user);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error deactivating user: " + e.getMessage());
            return false;
        }
    }

    public boolean activateUser(Long userId) {
        try {
            Optional<User> userOpt = userRepository.findById(userId);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                user.setActive(true);
                userRepository.save(user);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error activating user: " + e.getMessage());
            return false;
        }
    }

    public boolean changePassword(Long userId, String newPassword) {
        try {
            Optional<User> userOpt = userRepository.findById(userId);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                user.setPassword(newPassword);
                userRepository.save(user);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error changing password: " + e.getMessage());
            return false;
        }
    }
}
