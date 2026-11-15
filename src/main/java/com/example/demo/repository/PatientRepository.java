package com.example.demo.repository;

import com.example.demo.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PatientRepository extends JpaRepository<Patient, String> {

    Optional<Patient> findByUserId(String userId);

    @Query("SELECT p FROM Patient p WHERE " +
            "LOWER(p.name) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
            "LOWER(COALESCE(p.phoneNumber, '')) LIKE LOWER(CONCAT('%', :searchTerm, '%'))")
    List<Patient> findByNameContainingIgnoreCaseOrPhoneNumberContainingIgnoreCase(
            @Param("searchTerm") String name, @Param("searchTerm") String phone);

    List<Patient> findByIsPremiumMember(Boolean isPremium);

    List<Patient> findByNameContainingIgnoreCase(String name);

    @Query("SELECT p FROM Patient p WHERE p.isPremiumMember = true AND p.totalPoints > 0")
    List<Patient> findPremiumMembersWithPoints();

    @Query("SELECT p FROM Patient p ORDER BY p.name ASC")
    List<Patient> findAllOrderByNameAsc();

}
