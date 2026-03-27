# CodeVerse - Complete Repository Layer

## File: CodeVerseUserRepository.java
```java
package com.codeverse.repository;

import com.codeverse.entity.CodeVerseUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface CodeVerseUserRepository extends JpaRepository<CodeVerseUser, Long> {
    
    Optional<CodeVerseUser> findByUsername(String username);
    
    Optional<CodeVerseUser> findByEmail(String email);
    
    @Query("SELECT u FROM CodeVerseUser u WHERE u.userType.userTypeId = :userTypeId")
    List<CodeVerseUser> findByUserTypeId(@Param("userTypeId") Integer userTypeId);
    
    @Query("SELECT u FROM CodeVerseUser u WHERE u.userType.userTypeName = :userTypeName")
    List<CodeVerseUser> findByUserTypeName(@Param("userTypeName") String userTypeName);
    
    @Query("SELECT u FROM CodeVerseUser u WHERE u.isActive = :isActive")
    List<CodeVerseUser> findByIsActive(@Param("isActive") Boolean isActive);
    
    @Query("SELECT u FROM CodeVerseUser u WHERE u.email = :email AND u.resetOtp = :otp")
    Optional<CodeVerseUser> findByEmailAndResetOtp(@Param("email") String email, @Param("otp") String otp);
    
    boolean existsByUsername(String username);
    
    boolean existsByEmail(String email);
}
```

## File: CodeVerseUserTypeRepository.java
```java
package com.codeverse.repository;

import com.codeverse.entity.CodeVerseUserType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface CodeVerseUserTypeRepository extends JpaRepository<CodeVerseUserType, Integer> {
    
    Optional<CodeVerseUserType> findByUserTypeName(String userTypeName);
    
    boolean existsByUserTypeName(String userTypeName);
}
```

## File: CodeVerseCategoryRepository.java
```java
package com.codeverse.repository;

import com.codeverse.entity.CodeVerseCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface CodeVerseCategoryRepository extends JpaRepository<CodeVerseCategory, Long> {
    
    Optional<CodeVerseCategory> findByCategoryName(String categoryName);
    
    @Query("SELECT c FROM CodeVerseCategory c WHERE c.isActive = :isActive")
    List<CodeVerseCategory> findByIsActive(@Param("isActive") Boolean isActive);
    
    @Query("SELECT c FROM CodeVerseCategory c WHERE c.isActive = true ORDER BY c.categoryName ASC")
    List<CodeVerseCategory> findAllActiveCategories();
    
    boolean existsByCategoryName(String categoryName);
}
```

## File: CodeVerseHackathonRepository.java
```java
package com.codeverse.repository;

import com.codeverse.entity.CodeVerseHackathon;
import com.codeverse.entity.CodeVerseHackathon.HackathonStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface CodeVerseHackathonRepository extends JpaRepository<CodeVerseHackathon, Long> {
    
    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.organizer.userId = :organizerId ORDER BY h.createdAt DESC")
    List<CodeVerseHackathon> findByOrganizerId(@Param("organizerId") Long organizerId);
    
    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.category.categoryId = :categoryId AND h.isActive = true AND h.status = 'PUBLISHED'")
    List<CodeVerseHackathon> findByCategoryId(@Param("categoryId") Long categoryId);
    
    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.isActive = true AND h.status = 'PUBLISHED' ORDER BY h.eventDate ASC")
    List<CodeVerseHackathon> findAllActiveHackathons();
    
    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.status = :status ORDER BY h.eventDate ASC")
    List<CodeVerseHackathon> findByStatus(@Param("status") HackathonStatus status);
    
    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.eventDate >= :startDate AND h.isActive = true AND h.status = 'PUBLISHED'")
    List<CodeVerseHackathon> findUpcomingHackathons(@Param("startDate") LocalDate startDate);
    
    @Query("SELECT h FROM CodeVerseHackathon h WHERE h.availableSlots > 0 AND h.isActive = true AND h.status = 'PUBLISHED'")
    List<CodeVerseHackathon> findHackathonsWithAvailableSlots();
    
    @Query("SELECT h FROM CodeVerseHackathon h WHERE " +
           "(LOWER(h.hackathonTitle) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(h.hackathonDescription) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
           "h.isActive = true AND h.status = 'PUBLISHED'")
    List<CodeVerseHackathon> searchHackathons(@Param("keyword") String keyword);
}
```

## File: CodeVerseRegistrationRepository.java
```java
package com.codeverse.repository;

import com.codeverse.entity.CodeVerseRegistration;
import com.codeverse.entity.CodeVerseRegistration.RegistrationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface CodeVerseRegistrationRepository extends JpaRepository<CodeVerseRegistration, Long> {
    
    @Query("SELECT r FROM CodeVerseRegistration r WHERE r.participant.userId = :participantId ORDER BY r.registeredAt DESC")
    List<CodeVerseRegistration> findByParticipantId(@Param("participantId") Long participantId);
    
    @Query("SELECT r FROM CodeVerseRegistration r WHERE r.hackathon.hackathonId = :hackathonId ORDER BY r.registeredAt DESC")
    List<CodeVerseRegistration> findByHackathonId(@Param("hackathonId") Long hackathonId);
    
    @Query("SELECT r FROM CodeVerseRegistration r WHERE r.hackathon.hackathonId = :hackathonId AND r.participant.userId = :participantId")
    Optional<CodeVerseRegistration> findByHackathonIdAndParticipantId(
        @Param("hackathonId") Long hackathonId, 
        @Param("participantId") Long participantId);
    
    Optional<CodeVerseRegistration> findByRegistrationCode(String registrationCode);
    
    @Query("SELECT r FROM CodeVerseRegistration r WHERE r.registrationStatus = :status")
    List<CodeVerseRegistration> findByRegistrationStatus(@Param("status") RegistrationStatus status);
    
    @Query("SELECT COUNT(r) FROM CodeVerseRegistration r WHERE r.hackathon.hackathonId = :hackathonId AND r.registrationStatus = 'CONFIRMED'")
    Long countConfirmedRegistrations(@Param("hackathonId") Long hackathonId);
    
    boolean existsByHackathonHackathonIdAndParticipantUserId(Long hackathonId, Long participantId);
}
```
