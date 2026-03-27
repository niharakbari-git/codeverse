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
@RequestMapping("/organizer")
@RequiredArgsConstructor
public class CodeVerseOrganizerController {

    private final CodeVerseHackathonService hackathonService;
    private final CodeVerseCategoryService categoryService;
    private final CodeVerseRegistrationService registrationService;
    private final CodeVerseUserService userService;

    /**
     * Organizer dashboard
     */
    @GetMapping("/dashboard")
    public String showOrganizerDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || !("Organizer".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Organizer only.");
                return "redirect:/login";
            }
            
            Long organizerId = (Long) userId;
            List<CodeVerseHackathon> hackathons = hackathonService.findByOrganizer(organizerId);
            
            model.addAttribute("totalHackathons", hackathons.size());
            model.addAttribute("organizerName", session.getAttribute("fullName"));
            
            return "codeverse-organizer-dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/login";
        }
    }

    /**
     * List organizer's hackathons
     */
    @GetMapping("/hackathons")
    public String listHackathons(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || !("Organizer".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Organizer only.");
                return "redirect:/login";
            }
            
            Long organizerId = (Long) userId;
            List<CodeVerseHackathon> hackathons = hackathonService.findByOrganizer(organizerId);
            model.addAttribute("hackathons", hackathons);
            
            return "codeverse-organizer-hackathons";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred: " + e.getMessage());
            return "codeverse-organizer-hackathons";
        }
    }

    /**
     * Show create hackathon form
     */
    @GetMapping("/hackathons/new")
    public String showCreateHackathonForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Organizer".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Organizer only.");
                return "redirect:/login";
            }
            
            List<CodeVerseCategory> categories = categoryService.findAllActiveCategories();
            model.addAttribute("hackathon", new CodeVerseHackathon());
            model.addAttribute("categories", categories);
            
            return "codeverse-organizer-hackathon-form";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred: " + e.getMessage());
            return "error-page";
        }
    }

    /**
     * Create new hackathon
     */
    @PostMapping("/hackathons")
    public String createHackathon(CodeVerseHackathon hackathon, @RequestParam Long categoryId,
                                 HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || !("Organizer".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Organizer only.");
                return "redirect:/login";
            }
            
            Long organizerId = (Long) userId;
            Optional<CodeVerseUser> organizer = userService.findById(organizerId);
            Optional<CodeVerseCategory> category = categoryService.findById(categoryId);
            
            if (!organizer.isPresent() || !category.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Invalid organizer or category");
                return "redirect:/organizer/hackathons/new";
            }
            
            hackathon.setOrganizer(organizer.get());
            hackathon.setCategory(category.get());
            
            hackathonService.createHackathon(hackathon);
            redirectAttributes.addFlashAttribute("success", "Hackathon created successfully!");
            return "redirect:/organizer/hackathons";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/organizer/hackathons/new";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/organizer/hackathons/new";
        }
    }

    /**
     * Show edit hackathon form
     */
    @GetMapping("/hackathons/{id}/edit")
    public String showEditHackathonForm(@PathVariable Long id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Organizer".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Organizer only.");
                return "redirect:/login";
            }
            
            Optional<CodeVerseHackathon> hackathon = hackathonService.findById(id);
            if (hackathon.isPresent()) {
                List<CodeVerseCategory> categories = categoryService.findAllActiveCategories();
                model.addAttribute("hackathon", hackathon.get());
                model.addAttribute("categories", categories);
                return "codeverse-organizer-hackathon-form";
            } else {
                redirectAttributes.addFlashAttribute("error", "Hackathon not found");
                return "redirect:/organizer/hackathons";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/organizer/hackathons";
        }
    }

    /**
     * Update hackathon
     */
    @PostMapping("/hackathons/{id}")
    public String updateHackathon(@PathVariable Long id, CodeVerseHackathon updatedHackathon, 
                                 @RequestParam Long categoryId, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Organizer".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Organizer only.");
                return "redirect:/login";
            }
            
            Optional<CodeVerseCategory> category = categoryService.findById(categoryId);
            if (!category.isPresent()) {
                redirectAttributes.addFlashAttribute("error", "Invalid category");
                return "redirect:/organizer/hackathons/" + id + "/edit";
            }
            
            updatedHackathon.setCategory(category.get());
            hackathonService.updateHackathon(id, updatedHackathon);
            redirectAttributes.addFlashAttribute("success", "Hackathon updated successfully!");
            return "redirect:/organizer/hackathons";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/organizer/hackathons/" + id + "/edit";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/organizer/hackathons/" + id + "/edit";
        }
    }

    /**
     * Delete hackathon
     */
    @PostMapping("/hackathons/{id}/delete")
    public String deleteHackathon(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Organizer".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Organizer only.");
                return "redirect:/login";
            }
            
            Optional<CodeVerseHackathon> hackathon = hackathonService.findById(id);
            if (hackathon.isPresent()) {
                CodeVerseHackathon updated = hackathon.get();
                updated.setIsActive(false);
                hackathonService.updateHackathon(id, updated);
                redirectAttributes.addFlashAttribute("success", "Hackathon deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Hackathon not found");
            }
            
            return "redirect:/organizer/hackathons";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/organizer/hackathons";
        }
    }

    /**
     * View hackathon registrations
     */
    @GetMapping("/hackathons/{id}/registrations")
    public String viewRegistrations(@PathVariable Long id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Organizer".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Organizer only.");
                return "redirect:/login";
            }
            
            Optional<CodeVerseHackathon> hackathon = hackathonService.findById(id);
            if (hackathon.isPresent()) {
                List<CodeVerseRegistration> registrations = registrationService.findByHackathon(id);
                long totalRegistrations = registrationService.getTotalRegistrations(id);
                
                model.addAttribute("hackathon", hackathon.get());
                model.addAttribute("registrations", registrations);
                model.addAttribute("totalRegistrations", totalRegistrations);
                
                return "codeverse-organizer-registrations";
            } else {
                redirectAttributes.addFlashAttribute("error", "Hackathon not found");
                return "redirect:/organizer/hackathons";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/organizer/hackathons";
        }
    }
}
