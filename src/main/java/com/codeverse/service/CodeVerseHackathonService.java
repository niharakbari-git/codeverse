package com.codeverse.service;

import com.codeverse.entity.CodeVerseHackathon;
import com.codeverse.repository.CodeVerseHackathonRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CodeVerseHackathonService {

    private final CodeVerseHackathonRepository hackathonRepository;

    /**
     * Create a new hackathon
     */
    @Transactional
    public CodeVerseHackathon createHackathon(CodeVerseHackathon hackathon) {
        if (hackathon.getHackathonTitle() == null || hackathon.getHackathonTitle().trim().isEmpty()) {
            throw new RuntimeException("Hackathon title cannot be empty");
        }

        if (hackathon.getOrganizer() == null) {
            throw new RuntimeException("Organizer information is required");
        }

        if (hackathon.getCategory() == null) {
            throw new RuntimeException("Category information is required");
        }

        if (hackathon.getEventDate() == null) {
            throw new RuntimeException("Event date is required");
        }

        if (hackathon.getEventTime() == null) {
            throw new RuntimeException("Event time is required");
        }

        if (hackathon.getMaxSlots() == null || hackathon.getMaxSlots() <= 0) {
            throw new RuntimeException("Maximum slots must be greater than 0");
        }

        if (hackathon.getDurationHours() == null || hackathon.getDurationHours() <= 0) {
            throw new RuntimeException("Duration hours must be greater than 0");
        }

        hackathon.setAvailableSlots(hackathon.getMaxSlots());
        hackathon.setIsActive(true);
        hackathon.setCreatedAt(LocalDateTime.now());
        hackathon.setUpdatedAt(LocalDateTime.now());

        if (hackathon.getStatus() == null) {
            hackathon.setStatus(CodeVerseHackathon.HackathonStatus.PUBLISHED);
        }

        return hackathonRepository.save(hackathon);
    }

    /**
     * Update an existing hackathon
     */
    @Transactional
    @SuppressWarnings("null")
    public CodeVerseHackathon updateHackathon(Long hackathonId, CodeVerseHackathon updatedHackathon) {
        CodeVerseHackathon hackathon = hackathonRepository.findById(Long.valueOf(hackathonId))
                .orElseThrow(() -> new RuntimeException("Hackathon not found with ID: " + hackathonId));

        if (updatedHackathon.getHackathonTitle() != null && !updatedHackathon.getHackathonTitle().trim().isEmpty()) {
            hackathon.setHackathonTitle(updatedHackathon.getHackathonTitle());
        }

        if (updatedHackathon.getHackathonDescription() != null && !updatedHackathon.getHackathonDescription().trim().isEmpty()) {
            hackathon.setHackathonDescription(updatedHackathon.getHackathonDescription());
        }

        if (updatedHackathon.getEventDate() != null) {
            hackathon.setEventDate(updatedHackathon.getEventDate());
        }

        if (updatedHackathon.getEventTime() != null) {
            hackathon.setEventTime(updatedHackathon.getEventTime());
        }

        if (updatedHackathon.getDurationHours() != null && updatedHackathon.getDurationHours() > 0) {
            hackathon.setDurationHours(updatedHackathon.getDurationHours());
        }

        if (updatedHackathon.getVenueLocation() != null && !updatedHackathon.getVenueLocation().trim().isEmpty()) {
            hackathon.setVenueLocation(updatedHackathon.getVenueLocation());
        }

        if (updatedHackathon.getVenueType() != null) {
            hackathon.setVenueType(updatedHackathon.getVenueType());
        }

        if (updatedHackathon.getPrizePool() != null) {
            hackathon.setPrizePool(updatedHackathon.getPrizePool());
        }

        if (updatedHackathon.getRegistrationFee() != null) {
            hackathon.setRegistrationFee(updatedHackathon.getRegistrationFee());
        }

        if (updatedHackathon.getSkillsRequired() != null) {
            hackathon.setSkillsRequired(updatedHackathon.getSkillsRequired());
        }

        if (updatedHackathon.getBannerImage() != null) {
            hackathon.setBannerImage(updatedHackathon.getBannerImage());
        }

        if (updatedHackathon.getIsActive() != null) {
            hackathon.setIsActive(updatedHackathon.getIsActive());
        }

        if (updatedHackathon.getStatus() != null) {
            hackathon.setStatus(updatedHackathon.getStatus());
        }

        hackathon.setUpdatedAt(LocalDateTime.now());

        return hackathonRepository.save(hackathon);
    }

    /**
     * Find all published hackathons
     */
    public List<CodeVerseHackathon> findAllPublished() {
        return hackathonRepository.findAllPublishedHackathons();
    }

    /**
     * Find hackathons by organizer
     */
    public List<CodeVerseHackathon> findByOrganizer(Long userId) {
        return hackathonRepository.findByOrganizerId(userId);
    }

    /**
     * Find upcoming hackathons (event date >= today)
     */
    public List<CodeVerseHackathon> findUpcoming() {
        return hackathonRepository.findUpcomingHackathons(LocalDate.now());
    }

    /**
     * Search hackathons by keyword
     */
    public List<CodeVerseHackathon> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            throw new RuntimeException("Search keyword cannot be empty");
        }
        return hackathonRepository.searchHackathons(keyword.trim());
    }

    /**
     * Find hackathons by category
     */
    public List<CodeVerseHackathon> findByCategory(Long categoryId) {
        if (categoryId == null || categoryId <= 0) {
            throw new RuntimeException("Category ID must be valid");
        }
        return hackathonRepository.findByCategoryId(categoryId);
    }

    /**
     * Find hackathon by ID
     */
    @SuppressWarnings("null")
    public Optional<CodeVerseHackathon> findById(Long hackathonId) {
        return hackathonRepository.findById(Long.valueOf(hackathonId));
    }

    /**
     * Decrement available slots for a hackathon (when a user registers)
     * This method is transactional to ensure atomicity
     */
    @Transactional
    @SuppressWarnings("null")
    public void decrementSlot(Long hackathonId) {
        CodeVerseHackathon hackathon = hackathonRepository.findById(Long.valueOf(hackathonId))
                .orElseThrow(() -> new RuntimeException("Hackathon not found with ID: " + hackathonId));

        if (hackathon.getAvailableSlots() <= 0) {
            throw new RuntimeException("No slots available for this hackathon");
        }

        hackathon.setAvailableSlots(hackathon.getAvailableSlots() - 1);
        hackathon.setUpdatedAt(LocalDateTime.now());

        hackathonRepository.save(hackathon);
    }

    /**
     * Increment available slots (when a user cancels registration)
     */
    @Transactional
    @SuppressWarnings("null")
    public void incrementSlot(Long hackathonId) {
        CodeVerseHackathon hackathon = hackathonRepository.findById(Long.valueOf(hackathonId))
                .orElseThrow(() -> new RuntimeException("Hackathon not found with ID: " + hackathonId));

        if (hackathon.getAvailableSlots() >= hackathon.getMaxSlots()) {
            throw new RuntimeException("Cannot increment slots beyond maximum");
        }

        hackathon.setAvailableSlots(hackathon.getAvailableSlots() + 1);
        hackathon.setUpdatedAt(LocalDateTime.now());

        hackathonRepository.save(hackathon);
    }

    /**
     * Check if slots are available
     */
    @SuppressWarnings("null")
    public boolean hasAvailableSlots(Long hackathonId) {
        Optional<CodeVerseHackathon> hackathon = hackathonRepository.findById(Long.valueOf(hackathonId));
        return hackathon.isPresent() && hackathon.get().getAvailableSlots() > 0;
    }

    /**
     * Get available slots count
     */
    @SuppressWarnings("null")
    public int getAvailableSlots(Long hackathonId) {
        CodeVerseHackathon hackathon = hackathonRepository.findById(Long.valueOf(hackathonId))
                .orElseThrow(() -> new RuntimeException("Hackathon not found with ID: " + hackathonId));
        return hackathon.getAvailableSlots();
    }
}
