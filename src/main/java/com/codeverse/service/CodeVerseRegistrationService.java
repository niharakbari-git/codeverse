package com.codeverse.service;

import com.codeverse.entity.CodeVerseHackathon;
import com.codeverse.entity.CodeVerseRegistration;
import com.codeverse.entity.CodeVerseUser;
import com.codeverse.repository.CodeVerseHackathonRepository;
import com.codeverse.repository.CodeVerseRegistrationRepository;
import com.codeverse.repository.CodeVerseUserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class CodeVerseRegistrationService {

    private final CodeVerseRegistrationRepository registrationRepository;
    private final CodeVerseHackathonRepository hackathonRepository;
    private final CodeVerseUserRepository userRepository;
    private final CodeVerseHackathonService hackathonService;
    private final CodeVerseMailService mailService;

    /**
     * Register a user for a hackathon
     * Generates unique registration code: CV-YYYYMMDD-RANDOM6
     */
    @Transactional
    @SuppressWarnings("null")
    public CodeVerseRegistration registerForHackathon(Long hackathonId, CodeVerseUser participant, String teamName) {
        // Validate hackathon exists
        CodeVerseHackathon hackathon = hackathonRepository.findById(Long.valueOf(hackathonId))
                .orElseThrow(() -> new RuntimeException("Hackathon not found with ID: " + hackathonId));

        // Validate participant exists
        CodeVerseUser user = userRepository.findById(Long.valueOf(participant.getUserId()))
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + participant.getUserId()));

        // Check if user is already registered
        if (isAlreadyRegistered(hackathonId, participant.getUserId())) {
            throw new RuntimeException("User is already registered for this hackathon");
        }

        // Check if slots are available
        if (!hackathonService.hasAvailableSlots(hackathonId)) {
            throw new RuntimeException("No slots available for this hackathon. Please join the waitlist.");
        }

        // Create registration
        CodeVerseRegistration registration = new CodeVerseRegistration();
        registration.setHackathon(hackathon);
        registration.setParticipant(user);
        registration.setTeamName(teamName != null ? teamName : "Individual");
        registration.setTeamSize(1);
        registration.setRegistrationStatus(CodeVerseRegistration.RegistrationStatus.CONFIRMED);
        registration.setPaymentStatus(CodeVerseRegistration.PaymentStatus.PENDING);
        registration.setRegistrationCode(generateRegistrationCode());
        registration.setRegisteredAt(LocalDateTime.now());
        registration.setUpdatedAt(LocalDateTime.now());

        // Save registration
        CodeVerseRegistration savedRegistration = registrationRepository.save(registration);

        // Decrement available slots
        hackathonService.decrementSlot(hackathonId);

        // Send booking confirmation email
        try {
            mailService.sendBookingConfirmation(savedRegistration);
        } catch (Exception e) {
            // Log the error but don't fail the registration
            System.err.println("Failed to send booking confirmation email: " + e.getMessage());
        }

        return savedRegistration;
    }

    /**
     * Generate unique registration code: CV-YYYYMMDD-RANDOM6
     * Format: CV-20240115-ABC123
     */
    private String generateRegistrationCode() {
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String datePart = today.format(formatter);

        // Generate random 6-character alphanumeric string
        String randomPart = generateRandomString(6);

        return "CV-" + datePart + "-" + randomPart;
    }

    /**
     * Generate random alphanumeric string of given length
     */
    private String generateRandomString(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < length; i++) {
            result.append(chars.charAt(random.nextInt(chars.length())));
        }

        return result.toString();
    }

    /**
     * Check if a user is already registered for a hackathon
     */
    public boolean isAlreadyRegistered(Long hackathonId, Long participantId) {
        return registrationRepository.existsByHackathonIdAndParticipantId(hackathonId, participantId);
    }

    /**
     * Find registrations by participant (user)
     */
    public List<CodeVerseRegistration> findByParticipant(Long userId) {
        if (userId == null || userId <= 0) {
            throw new RuntimeException("User ID must be valid");
        }
        return registrationRepository.findByParticipantId(userId);
    }

    /**
     * Find registrations by hackathon
     */
    public List<CodeVerseRegistration> findByHackathon(Long hackathonId) {
        if (hackathonId == null || hackathonId <= 0) {
            throw new RuntimeException("Hackathon ID must be valid");
        }
        return registrationRepository.findByHackathonId(hackathonId);
    }

    /**
     * Find registration by registration code
     */
    public Optional<CodeVerseRegistration> findByRegistrationCode(String registrationCode) {
        if (registrationCode == null || registrationCode.trim().isEmpty()) {
            throw new RuntimeException("Registration code cannot be empty");
        }
        return registrationRepository.findByRegistrationCode(registrationCode);
    }

    /**
     * Find registration by ID
     */
    @SuppressWarnings("null")
    public Optional<CodeVerseRegistration> findById(Long registrationId) {
        return registrationRepository.findById(Long.valueOf(registrationId));
    }

    /**
     * Cancel registration
     */
    @Transactional
    @SuppressWarnings("null")
    public void cancelRegistration(Long registrationId) {
        CodeVerseRegistration registration = registrationRepository.findById(Long.valueOf(registrationId))
                .orElseThrow(() -> new RuntimeException("Registration not found with ID: " + registrationId));

        if (registration.getRegistrationStatus() == CodeVerseRegistration.RegistrationStatus.CANCELLED) {
            throw new RuntimeException("Registration is already cancelled");
        }

        registration.setRegistrationStatus(CodeVerseRegistration.RegistrationStatus.CANCELLED);
        registration.setUpdatedAt(LocalDateTime.now());

        registrationRepository.save(registration);

        // Increment available slots
        hackathonService.incrementSlot(registration.getHackathon().getHackathonId());
    }

    /**
     * Update registration status
     */
    @Transactional
    @SuppressWarnings("null")
    public CodeVerseRegistration updateRegistrationStatus(Long registrationId, CodeVerseRegistration.RegistrationStatus status) {
        CodeVerseRegistration registration = registrationRepository.findById(Long.valueOf(registrationId))
                .orElseThrow(() -> new RuntimeException("Registration not found with ID: " + registrationId));

        registration.setRegistrationStatus(status);
        registration.setUpdatedAt(LocalDateTime.now());

        return registrationRepository.save(registration);
    }

    /**
     * Update payment status
     */
    @Transactional
    @SuppressWarnings("null")
    public CodeVerseRegistration updatePaymentStatus(Long registrationId, CodeVerseRegistration.PaymentStatus status) {
        CodeVerseRegistration registration = registrationRepository.findById(Long.valueOf(registrationId))
                .orElseThrow(() -> new RuntimeException("Registration not found with ID: " + registrationId));

        registration.setPaymentStatus(status);
        registration.setUpdatedAt(LocalDateTime.now());

        return registrationRepository.save(registration);
    }

    /**
     * Update team name and special requirements
     */
    @Transactional
    @SuppressWarnings("null")
    public CodeVerseRegistration updateRegistrationDetails(Long registrationId, String teamName, String specialRequirements) {
        CodeVerseRegistration registration = registrationRepository.findById(Long.valueOf(registrationId))
                .orElseThrow(() -> new RuntimeException("Registration not found with ID: " + registrationId));

        if (teamName != null && !teamName.trim().isEmpty()) {
            registration.setTeamName(teamName);
        }

        if (specialRequirements != null) {
            registration.setSpecialRequirements(specialRequirements);
        }

        registration.setUpdatedAt(LocalDateTime.now());

        return registrationRepository.save(registration);
    }

    /**
     * Get total registrations for a hackathon
     */
    public long getTotalRegistrations(Long hackathonId) {
        List<CodeVerseRegistration> registrations = findByHackathon(hackathonId);
        return registrations.stream()
                .filter(r -> r.getRegistrationStatus() != CodeVerseRegistration.RegistrationStatus.CANCELLED)
                .count();
    }
}
