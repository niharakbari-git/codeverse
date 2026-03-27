package com.codeverse.repository;

import com.codeverse.entity.CodeVerseHackathon;
import com.codeverse.entity.CodeVerseUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface CodeVerseHackathonRepository extends JpaRepository<CodeVerseHackathon, Long> {

    List<CodeVerseHackathon> findByOrganizer(CodeVerseUser organizer);

    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.isActive = true AND h.status = 'PUBLISHED' ORDER BY h.eventDate ASC")
    List<CodeVerseHackathon> findAllPublishedHackathons();

    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.category.categoryId = ?1 AND h.isActive = true AND h.status = 'PUBLISHED'")
    List<CodeVerseHackathon> findByCategoryId(Long categoryId);

    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.eventDate >= :today AND h.isActive = true AND h.status = 'PUBLISHED'")
    List<CodeVerseHackathon> findUpcomingHackathons(@Param("today") LocalDate today);

    @Query("SELECT h FROM CodeVerseHackathon h WHERE " +
           "(LOWER(h.hackathonTitle) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(h.hackathonDescription) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
           "AND h.isActive = true AND h.status = 'PUBLISHED'")
    List<CodeVerseHackathon> searchHackathons(@Param("keyword") String keyword);

    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.organizer.userId = :userId ORDER BY h.createdAt DESC")
    List<CodeVerseHackathon> findByOrganizerId(@Param("userId") Long userId);
}
