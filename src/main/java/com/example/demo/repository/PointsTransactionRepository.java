package com.example.demo.repository;

import com.example.demo.model.PointsTransaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface PointsTransactionRepository extends JpaRepository<PointsTransaction, Long> {
    List<PointsTransaction> findByPatientUserIdOrderByTransactionDateDesc(String patientUserId);

    @Transactional
    void deleteByPatientUserId(String patientUserId);
}


