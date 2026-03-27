package com.codeverse.controller;

import com.codeverse.entity.CodeVerseCategory;
import com.codeverse.entity.CodeVerseHackathon;
import com.codeverse.entity.CodeVerseRegistration;
import com.codeverse.entity.CodeVerseUser;
import com.codeverse.service.CodeVerseCategoryService;
import com.codeverse.service.CodeVerseHackathonService;
import com.codeverse.service.CodeVerseRegistrationService;
import com.codeverse.service.CodeVerseUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/participant")
@RequiredArgsConstructor
public class CodeVerseParticipantController {

    private final CodeVerseHackathonService hackathonService;
    private final CodeVerseCategoryService categoryService;
    private final CodeVerseRegistrationService registrationService;
    private final CodeVerseUserService userService;

    /**
     * Participant dashboard
     */
    @GetMapping("/dashboard")
    public String showParticipantDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || !("Participant".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Participant only.");
                return "redirect:/login";
            }
            
            Long participantId = (Long) userId;
            List<CodeVerseRegistration> bookings = registrationService.findByParticipant(participantId);
            List<CodeVerseHackathon> upcomingHackathons = hackathonService.findUpcoming();
            
            model.addAttribute("totalBookings", bookings.size());
            model.addAttribute("upcomingHackathons", upcomingHackathons.size());
            model.addAttribute("participantName", session.getAttribute("fullName"));
            
            return "codeverse-participant-dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/login";
        }
    }

    /**
     * Hackathon marketplace with search and filters
     */
    @GetMapping("/explore")
    public String exploreHackathons(@RequestParam(required = false) String keyword,
                                   @RequestParam(required = false) Long categoryId,
                                   HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Participant".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Participant only.");
                return "redirect:/login";
            }
            
            List<CodeVerseHackathon> hackathons;
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                hackathons = hackathonService.search(keyword);
            } else if (categoryId != null && categoryId > 0) {
                hackathons = hackathonService.findByCategory(categoryId);
            } else {
                hackathons = hackathonService.findAllPublished();
            }
            
            List<CodeVerseCategory> categories = categoryService.findAllActiveCategories();
            model.addAttribute("hackathons", hackathons);
            model.addAttribute("categories", categories);
            model.addAttribute("keyword", keyword);
            model.addAttribute("categoryId", categoryId);
            
            return "codeverse-participant-explore";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred: " + e.getMessage());
            return "codeverse-participant-explore";
        }
    }

    /**
     * View hackathon details
     */
    @GetMapping("/hackathons/{id}")
    public String viewHackathonDetails(@PathVariable Long id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || !("Participant".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Participant only.");
                return "redirect:/login";
            }
            
            Optional<CodeVerseHackathon> hackathon = hackathonService.findById(id);
            if (hackathon.isPresent()) {
                Long participantId = (Long) userId;
                boolean isAlreadyBooked = registrationService.isAlreadyRegistered(id, participantId);
                boolean hasSlots = hackathonService.hasAvailableSlots(id);
                
                model.addAttribute("hackathon", hackathon.get());
                model.addAttribute("isAlreadyBooked", isAlreadyBooked);
                model.addAttribute("hasSlots", hasSlots);
                
                return "codeverse-participant-hackathon-details";
            } else {
                redirectAttributes.addFlashAttribute("error", "Hackathon not found");
                return "redirect:/participant/explore";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/participant/explore";
        }
    }

    /**
     * Book a slot for a hackathon
     */
    @PostMapping("/hackathons/{id}/book")
    public String bookHackathon(@PathVariable Long id, 
                               @RequestParam(required = false) String teamName,
                               HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || !("Participant".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Participant only.");
                return "redirect:/login";
            }
            
            Long participantId = (Long) userId;
            Optional<CodeVerseUser> participant = userService.findById(participantId);
            
            if (!participant.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Participant not found");
                return "redirect:/participant/explore";
            }
            
            CodeVerseRegistration registration = registrationService.registerForHackathon(id, participant.get(), teamName);
            redirectAttributes.addFlashAttribute("success", "Successfully booked! Registration code: " + registration.getRegistrationCode());
            return "redirect:/participant/my-bookings";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/participant/hackathons/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/participant/hackathons/" + id;
        }
    }

    /**
     * View participant's bookings
     */
    @GetMapping("/my-bookings")
    public String viewMyBookings(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || !("Participant".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Participant only.");
                return "redirect:/login";
            }
            
            Long participantId = (Long) userId;
            List<CodeVerseRegistration> registrations = registrationService.findByParticipant(participantId);
            
            model.addAttribute("registrations", registrations);
            model.addAttribute("participantName", session.getAttribute("fullName"));
            
            return "codeverse-participant-my-bookings";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred: " + e.getMessage());
            return "codeverse-participant-my-bookings";
        }
    }
}