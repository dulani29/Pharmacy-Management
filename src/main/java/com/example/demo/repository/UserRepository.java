package com.example.demo.repository;

import com.example.demo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Basic User Queries
    User findByUsername(String username);
    User findByEmail(String email);
    User findByUsernameAndRole(String username, String role);

    // Existence Checks
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    // Role-based Queries
    @Query("SELECT u FROM User u WHERE u.role = ?1")
    List<User> findByRole(String role);

    // Active/Inactive User Queries
    @Query("SELECT u FROM User u WHERE u.isActive = true ORDER BY u.createdAt DESC")
    List<User> findActiveUsersOrderByCreatedAt();

    @Query("SELECT u FROM User u WHERE u.isActive = false")
    List<User> findInactiveUsers();

    @Query("SELECT u FROM User u WHERE u.role = ?1 AND u.isActive = true")
    List<User> findActiveUsersByRole(String role);

    // Count Queries
    @Query("SELECT COUNT(u) FROM User u WHERE u.isActive = true")
    long countActiveUsers();

    @Query("SELECT COUNT(u) FROM User u WHERE u.role = ?1")
    long countByRole(String role);

    @Query("SELECT COUNT(u) FROM User u WHERE u.role = ?1 AND u.isActive = true")
    long countActiveUsersByRole(String role);

    // Search Queries
    @Query("SELECT u FROM User u WHERE u.firstName LIKE %?1% OR u.lastName LIKE %?1%")
    List<User> findByNameContaining(String name);

    // Statistics Queries
    @Query("SELECT u.role, COUNT(u) FROM User u GROUP BY u.role")
    List<Object[]> getUserStatisticsByRole();

    @Query("SELECT u.role, COUNT(u) FROM User u WHERE u.isActive = true GROUP BY u.role")
    List<Object[]> getActiveUserStatisticsByRole();
}
