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
