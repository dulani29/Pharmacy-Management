package com.example.demo.repository;

import com.example.demo.model.PriceHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface PriceHistoryRepository extends JpaRepository<PriceHistory, Long> {

    List<PriceHistory> findByMedicineIdOrderByChangedAtDesc(Long medicineId);

    List<PriceHistory> findByChangedByOrderByChangedAtDesc(String changedBy);

    @Query("SELECT ph FROM PriceHistory ph WHERE ph.changedAt BETWEEN :startDate AND :endDate ORDER BY ph.changedAt DESC")
    List<PriceHistory> findByDateRangeOrderByChangedAtDesc(
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);

    @Query("SELECT COUNT(ph) FROM PriceHistory ph WHERE ph.changedAt BETWEEN :startDate AND :endDate")
    long countPriceChangesByDateRange(
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);

    @Query("SELECT ph FROM PriceHistory ph WHERE ph.medicineId = :medicineId AND ph.changedAt BETWEEN :startDate AND :endDate ORDER BY ph.changedAt DESC")
    List<PriceHistory> findByMedicineIdAndDateRangeOrderByChangedAtDesc(
            @Param("medicineId") Long medicineId,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);
}
