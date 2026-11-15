package com.example.demo.repository;

import com.example.demo.model.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Long> {

    // Basic search methods
    List<Medicine> findByNameContainingIgnoreCase(String name);
    List<Medicine> findByType(String type);
    List<Medicine> findByCategoryIgnoreCase(String category);
    List<Medicine> findByTypeIgnoreCase(String type);
    List<Medicine> findByCompanyIgnoreCase(String company);
    boolean existsByNameIgnoreCase(String name);

    // FIXED: Added the missing method that MedicineService expects
    List<Medicine> findByNameContainingIgnoreCaseOrCompanyContainingIgnoreCaseOrTypeContainingIgnoreCase(
            String name, String company, String type);

    // Existing method (keeping both for compatibility)
    List<Medicine> findByNameContainingIgnoreCaseOrTypeContainingIgnoreCaseOrCompanyContainingIgnoreCase(
            String name, String type, String company);

    // Inventory management methods
    List<Medicine> findAllByOrderByNameAsc();

    @Query("SELECT DISTINCT m.type FROM Medicine m WHERE m.type IS NOT NULL ORDER BY m.type")
    List<String> findDistinctTypes();

    @Query("SELECT DISTINCT m.category FROM Medicine m WHERE m.category IS NOT NULL ORDER BY m.category")
    List<String> findDistinctCategories();

    @Query("SELECT DISTINCT m.company FROM Medicine m WHERE m.company IS NOT NULL ORDER BY m.company")
    List<String> findDistinctCompanies();

    // Stock management methods
    @Query("SELECT m FROM Medicine m WHERE m.quantity <= m.minimumStock")
    List<Medicine> findLowStockMedicines();

    @Query("SELECT m FROM Medicine m WHERE m.quantity <= 0")
    List<Medicine> findOutOfStockMedicines();

    @Query("SELECT m FROM Medicine m WHERE m.quantity > (m.minimumStock * 2)")
    List<Medicine> findHighStockMedicines();

    @Query("SELECT m FROM Medicine m WHERE m.quantity > m.minimumStock AND m.quantity <= (m.minimumStock * 2)")
    List<Medicine> findMediumStockMedicines();

    // FIXED: Added missing methods that MedicineService expects
    long countByQuantityLessThan(int threshold);
    List<Medicine> findByQuantityLessThanOrderByQuantityAsc(int threshold);
    long countByExpiryDateBefore(LocalDate date);
    List<Medicine> findByExpiryDateBeforeOrderByExpiryDateAsc(LocalDate date);

    // Expiry date management
    @Query("SELECT m FROM Medicine m WHERE m.expiryDate <= :date")
    List<Medicine> findExpiringSoon(@Param("date") LocalDate date);

    @Query("SELECT m FROM Medicine m WHERE m.expiryDate <= :cutoffDate")
    List<Medicine> findByExpiryDateBefore(@Param("cutoffDate") LocalDate cutoffDate);

    @Query("SELECT m FROM Medicine m WHERE m.expiryDate BETWEEN :startDate AND :endDate ORDER BY m.expiryDate ASC")
    List<Medicine> findMedicinesExpiringBetween(@Param("startDate") LocalDate startDate,
                                                @Param("endDate") LocalDate endDate);

    @Query("SELECT m FROM Medicine m WHERE m.expiryDate < CURRENT_DATE")
    List<Medicine> findExpiredMedicines();

    // Advanced filtering
    @Query("SELECT m FROM Medicine m WHERE " +
            "(:name IS NULL OR LOWER(m.name) LIKE LOWER(CONCAT('%', :name, '%'))) AND " +
            "(:category IS NULL OR LOWER(m.category) = LOWER(:category)) AND " +
            "(:type IS NULL OR LOWER(m.type) = LOWER(:type))")
    List<Medicine> findMedicinesWithFilters(@Param("name") String name,
                                            @Param("category") String category,
                                            @Param("type") String type);

    @Query("SELECT m FROM Medicine m WHERE " +
            "(:query IS NULL OR " +
            "LOWER(m.name) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(m.company) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(m.type) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
            "LOWER(m.category) LIKE LOWER(CONCAT('%', :query, '%'))) AND " +
            "(:category IS NULL OR LOWER(m.category) = LOWER(:category)) AND " +
            "(:type IS NULL OR LOWER(m.type) = LOWER(:type)) AND " +
            "(:stockLevel IS NULL OR " +
            "(:stockLevel = 'high' AND m.quantity > (m.minimumStock * 2)) OR " +
            "(:stockLevel = 'medium' AND m.quantity > m.minimumStock AND m.quantity <= (m.minimumStock * 2)) OR " +
            "(:stockLevel = 'low' AND m.quantity > 0 AND m.quantity <= m.minimumStock) OR " +
            "(:stockLevel = 'out' AND m.quantity <= 0))")
    List<Medicine> findMedicinesWithAdvancedFilters(@Param("query") String query,
                                                    @Param("category") String category,
                                                    @Param("type") String type,
                                                    @Param("stockLevel") String stockLevel);

    // Category management
    @Query("SELECT COUNT(m) FROM Medicine m WHERE LOWER(m.category) = LOWER(:category)")
    Long countByCategory(@Param("category") String category);

    @Query("SELECT m FROM Medicine m WHERE m.category IS NULL OR m.category = '' OR LOWER(m.category) = 'uncategorized'")
    List<Medicine> findUncategorizedMedicines();

    @Query("SELECT m FROM Medicine m WHERE LOWER(m.category) = LOWER(:category) ORDER BY m.name ASC")
    List<Medicine> findByCategoryOrderByName(@Param("category") String category);

    // Statistics queries
    @Query("SELECT m.category, COUNT(m) FROM Medicine m WHERE m.category IS NOT NULL GROUP BY m.category ORDER BY COUNT(m) DESC")
    List<Object[]> getCategoryCountStats();

    @Query("SELECT COUNT(DISTINCT m.category) FROM Medicine m WHERE m.category IS NOT NULL")
    Long countDistinctCategories();

    // Price-based queries
    @Query("SELECT m FROM Medicine m WHERE m.price BETWEEN :minPrice AND :maxPrice")
    List<Medicine> findMedicinesByPriceRange(@Param("minPrice") Double minPrice,
                                             @Param("maxPrice") Double maxPrice);

    @Query("SELECT AVG(m.price) FROM Medicine m")
    Double getAveragePrice();

    @Query("SELECT AVG(m.price) FROM Medicine m WHERE LOWER(m.category) = LOWER(:category)")
    Double getAveragePriceByCategory(@Param("category") String category);

    // Bulk operations support
    @Query("SELECT m FROM Medicine m WHERE m.id IN :ids")
    List<Medicine> findByIdIn(@Param("ids") List<Long> ids);

    // Enhanced search
    @Query("SELECT m FROM Medicine m WHERE " +
            "LOWER(m.name) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
            "LOWER(m.company) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
            "LOWER(m.type) LIKE LOWER(CONCAT('%', :searchTerm, '%')) " +
            "ORDER BY " +
            "CASE WHEN LOWER(m.name) LIKE LOWER(CONCAT('%', :searchTerm, '%')) THEN 1 " +
            "WHEN LOWER(m.company) LIKE LOWER(CONCAT('%', :searchTerm, '%')) THEN 2 " +
            "ELSE 3 END")
    List<Medicine> findMedicinesBySearchTerm(@Param("searchTerm") String searchTerm);

    // Advanced inventory reports
    @Query("SELECT m.category, COUNT(m), SUM(m.quantity), AVG(m.price) " +
            "FROM Medicine m WHERE m.category IS NOT NULL " +
            "GROUP BY m.category ORDER BY m.category")
    List<Object[]> getInventoryReportByCategory();

    @Query("SELECT m.type, COUNT(m), SUM(m.quantity), AVG(m.price) " +
            "FROM Medicine m WHERE m.type IS NOT NULL " +
            "GROUP BY m.type ORDER BY m.type")
    List<Object[]> getInventoryReportByType();

    @Query("SELECT m.company, COUNT(m), SUM(m.quantity), AVG(m.price) " +
            "FROM Medicine m WHERE m.company IS NOT NULL " +
            "GROUP BY m.company ORDER BY COUNT(m) DESC")
    List<Object[]> getInventoryReportByCompany();
}
