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
