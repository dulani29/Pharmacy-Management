package com.example.demo.service;

import com.example.demo.model.PriceHistory;
import com.example.demo.model.User;
import com.example.demo.repository.PriceHistoryRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class AdminService {

    @Autowired
    private PriceHistoryRepository priceHistoryRepository;

    @Autowired
    private UserRepository userRepository;

    // Basic CRUD Operations
    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User findById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public User save(User user) {
        return userRepository.save(user);
    }

    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }

    // Validation Methods
    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    // User Finder Methods
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public List<User> findByRole(String role) {
        return userRepository.findByRole(role);
    }

    // Statistics Methods (Fixed method names for AdminController)
    public long getActiveUsersCount() {
        return userRepository.countActiveUsers();
    }

    public long getTotalUsersCount() {
        return userRepository.count();
    }

    public long getUserCountByRole(String role) {
        return userRepository.countByRole(role);
    }

    public long getActiveUserCountByRole(String role) {
        return userRepository.countActiveUsersByRole(role);
    }

    // User Status Management
    public void updateUserStatus(Long id, boolean active) {
        Optional<User> optionalUser = userRepository.findById(id);
        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setActive(active);
            userRepository.save(user);
        }
    }

    // Additional Utility Methods
    public List<User> getActiveUsers() {
        return userRepository.findActiveUsersOrderByCreatedAt();
    }

    public List<User> getActiveUsersByRole(String role) {
        return userRepository.findActiveUsersByRole(role);
    }

    public List<User> getInactiveUsers() {
        return userRepository.findInactiveUsers();
    }

    // Search Methods
    public List<User> searchUsersByName(String name) {
        return userRepository.findByNameContaining(name);
    }

    // Statistics for Dashboard
    public List<Object[]> getUserStatistics() {
        return userRepository.getUserStatisticsByRole();
    }

    public List<Object[]> getActiveUserStatistics() {
        return userRepository.getActiveUserStatisticsByRole();
    }

    public void logPriceChange(Long medicineId, double oldPrice, double newPrice, String reason) {
        PriceHistory priceHistory = new PriceHistory();
        priceHistory.setMedicineId(medicineId);
        priceHistory.setOldPrice(oldPrice);
        priceHistory.setNewPrice(newPrice);
        priceHistory.setReason(reason);
        priceHistory.setChangedAt(LocalDateTime.now());
        priceHistory.setChangedBy("admin"); // You can get this from session

        priceHistoryRepository.save(priceHistory);
    }

    public List<Map<String, Object>> getPriceHistory(Long medicineId) {
        List<PriceHistory> history = priceHistoryRepository.findByMedicineIdOrderByChangedAtDesc(medicineId);
        return history.stream().map(h -> {
            Map<String, Object> map = new HashMap<>();
            map.put("oldPrice", h.getOldPrice());
            map.put("newPrice", h.getNewPrice());
            map.put("reason", h.getReason());
            map.put("changedAt", h.getChangedAt().toString());
            map.put("changedBy", h.getChangedBy());
            return map;
        }).collect(java.util.stream.Collectors.toList());
    }
}
