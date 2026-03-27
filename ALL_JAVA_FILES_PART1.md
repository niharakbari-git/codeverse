# CodeVerse - Complete Java Source Files

## Instructions:
1. Run `setup-structure.bat` to create directory structure
2. Copy each file below to its respective location
3. File paths are indicated before each code block

---

## File: src/main/java/com/codeverse/CodeVerseApplication.java

```java
package com.codeverse;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class CodeVerseApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(CodeVerseApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(CodeVerseApplication.class, args);
        System.out.println("╔═══════════════════════════════════════════════╗");
        System.out.println("║   CodeVerse Hackathon Marketplace Started!   ║");
        System.out.println("║   Access: http://localhost:8080/codeverse    ║");
        System.out.println("╚═══════════════════════════════════════════════╝");
    }
}
```

---

## File: src/main/java/com/codeverse/entity/CodeVerseUserType.java

```java
package com.codeverse.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "codeverse_user_types")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CodeVerseUserType {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_type_id")
    private Integer userTypeId;

    @Column(name = "user_type_name", nullable = false, unique = true, length = 50)
    private String userTypeName;

    @Column(name = "user_type_description")
    private String userTypeDescription;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
```

---

## File: src/main/java/com/codeverse/entity/CodeVerseUser.java

```java
package com.codeverse.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "codeverse_users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CodeVerseUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long userId;

    @Column(nullable = false, unique = true, length = 100)
    private String username;

    @Column(nullable = false, unique = true, length = 150)
    private String email;

    @Column(nullable = false, length = 255)
    private String password;

    @Column(name = "full_name", nullable = false, length = 200)
    private String fullName;

    @Column(name = "phone_number", length = 20)
    private String phoneNumber;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_type_id", nullable = false)
    private CodeVerseUserType userType;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @Column(name = "is_verified")
    private Boolean isVerified = false;

    @Column(name = "profile_image", length = 500)
    private String profileImage;

    @Column(name = "reset_otp", length = 6)
    private String resetOtp;

    @Column(name = "otp_expiry")
    private LocalDateTime otpExpiry;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
```

---

## File: src/main/java/com/codeverse/entity/CodeVerseCategory.java

```java
package com.codeverse.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "codeverse_categories")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CodeVerseCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    private Long categoryId;

    @Column(name = "category_name", nullable = false, unique = true, length = 100)
    private String categoryName;

    @Column(name = "category_description", columnDefinition = "TEXT")
    private String categoryDescription;

    @Column(name = "category_icon", length = 100)
    private String categoryIcon;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}
```

---

## File: src/main/java/com/codeverse/entity/CodeVerseHackathon.java

```java
package com.codeverse.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;

@Entity
@Table(name = "codeverse_hackathons")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CodeVerseHackathon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "hackathon_id")
    private Long hackathonId;

    @Column(name = "hackathon_title", nullable = false)
    private String hackathonTitle;

    @Column(name = "hackathon_description", nullable = false, columnDefinition = "TEXT")
    private String hackathonDescription;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "organizer_id", nullable = false)
    private CodeVerseUser organizer;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id", nullable = false)
    private CodeVerseCategory category;

    @Column(name = "event_date", nullable = false)
    private LocalDate eventDate;

    @Column(name = "event_time", nullable = false)
    private LocalTime eventTime;

    @Column(name = "duration_hours", nullable = false)
    private Integer durationHours;

    @Column(name = "venue_location", nullable = false, length = 500)
    private String venueLocation;

    @Enumerated(EnumType.STRING)
    @Column(name = "venue_type")
    private VenueType venueType = VenueType.OFFLINE;

    @Column(name = "max_slots", nullable = false)
    private Integer maxSlots;

    @Column(name = "available_slots", nullable = false)
    private Integer availableSlots;

    @Column(name = "prize_pool", precision = 10, scale = 2)
    private BigDecimal prizePool;

    @Column(name = "registration_fee", precision = 10, scale = 2)
    private BigDecimal registrationFee = BigDecimal.ZERO;

    @Column(name = "skills_required", columnDefinition = "TEXT")
    private String skillsRequired;

    @Column(name = "banner_image", length = 500)
    private String bannerImage;

    @Column(name = "is_active")
    private Boolean isActive = true;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private HackathonStatus status = HackathonStatus.PUBLISHED;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public enum VenueType {
        ONLINE, OFFLINE, HYBRID
    }

    public enum HackathonStatus {
        DRAFT, PUBLISHED, ONGOING, COMPLETED, CANCELLED
    }
}
```

---

## File: src/main/java/com/codeverse/entity/CodeVerseRegistration.java

```java
package com.codeverse.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "codeverse_registrations", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"hackathon_id", "participant_id"})
})
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CodeVerseRegistration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "registration_id")
    private Long registrationId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "hackathon_id", nullable = false)
    private CodeVerseHackathon hackathon;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "participant_id", nullable = false)
    private CodeVerseUser participant;

    @Enumerated(EnumType.STRING)
    @Column(name = "registration_status")
    private RegistrationStatus registrationStatus = RegistrationStatus.CONFIRMED;

    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;

    @Column(name = "registration_code", unique = true, nullable = false, length = 50)
    private String registrationCode;

    @Column(name = "team_name", length = 200)
    private String teamName;

    @Column(name = "team_size")
    private Integer teamSize = 1;

    @Column(name = "special_requirements", columnDefinition = "TEXT")
    private String specialRequirements;

    @Column(name = "registered_at", updatable = false)
    private LocalDateTime registeredAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        registeredAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public enum RegistrationStatus {
        PENDING, CONFIRMED, CANCELLED, WAITLISTED
    }

    public enum PaymentStatus {
        PENDING, PAID, REFUNDED
    }
}
```

---

## Continue in next message due to length...
