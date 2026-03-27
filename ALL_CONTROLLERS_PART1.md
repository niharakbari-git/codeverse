# CodeVerse - Complete Controllers

## File: CodeVerseAuthController.java
```java
package com.codeverse.controller;

import com.codeverse.entity.CodeVerseUser;
import com.codeverse.service.CodeVerseUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.Optional;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class CodeVerseAuthController {

    private final CodeVerseUserService codeVerseUserService;

    @GetMapping("/login")
    public String showCodeVerseLoginPage(Model model) {
        return "CodeVerseLogin";
    }

    @PostMapping("/login")
    public String processCodeVerseLogin(@RequestParam String username,
                                        @RequestParam String password,
                                        HttpSession session,
                                        RedirectAttributes redirectAttributes) {
        try {
            Optional<CodeVerseUser> user = codeVerseUserService.authenticateCodeVerseUser(username, password);
            
            if (user.isPresent()) {
                session.setAttribute("codeVerseUser", user.get());
                session.setAttribute("codeVerseUserId", user.get().getUserId());
                session.setAttribute("codeVerseUsername", user.get().getUsername());
                session.setAttribute("codeVerseUserType", user.get().getUserType().getUserTypeName());
                
                redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "Welcome back, " + user.get().getFullName() + "!");
                return "redirect:/auth/dashboard";
            } else {
                redirectAttributes.addFlashAttribute("codeVerseErrorMessage", "Invalid username or password");
                return "redirect:/auth/login";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
            return "redirect:/auth/login";
        }
    }

    @GetMapping("/register")
    public String showCodeVerseRegisterPage(Model model) {
        return "CodeVerseRegister";
    }

    @PostMapping("/register")
    public String processCodeVerseRegistration(@ModelAttribute CodeVerseUser user,
                                              @RequestParam String userType,
                                              RedirectAttributes redirectAttributes) {
        try {
            codeVerseUserService.registerCodeVerseUser(user, userType);
            redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", 
                "Registration successful! Please check your email for confirmation.");
            return "redirect:/auth/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
            return "redirect:/auth/register";
        }
    }

    @GetMapping("/dashboard")
    public String showCodeVerseDashboard(HttpSession session, RedirectAttributes redirectAttributes) {
        String userType = (String) session.getAttribute("codeVerseUserType");
        
        if (userType == null) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", "Please login first");
            return "redirect:/auth/login";
        }
        
        return switch (userType) {
            case "ADMIN" -> "redirect:/admin/dashboard";
            case "ORGANIZER" -> "redirect:/organizer/dashboard";
            case "PARTICIPANT" -> "redirect:/participant/explore";
            default -> "redirect:/auth/login";
        };
    }

    @GetMapping("/logout")
    public String processCodeVerseLogout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "Logged out successfully");
        return "redirect:/auth/login";
    }

    @GetMapping("/forgot-password")
    public String showCodeVerseForgotPasswordPage() {
        return "CodeVerseForgotPassword";
    }

    @PostMapping("/forgot-password")
    public String processCodeVerseForgotPassword(@RequestParam String email, 
                                                 RedirectAttributes redirectAttributes) {
        try {
            codeVerseUserService.generatePasswordResetOTP(email);
            redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", 
                "OTP sent to your email. Please check your inbox.");
            return "redirect:/auth/reset-password";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
            return "redirect:/auth/forgot-password";
        }
    }

    @GetMapping("/reset-password")
    public String showCodeVerseResetPasswordPage() {
        return "CodeVerseResetPassword";
    }

    @PostMapping("/reset-password")
    public String processCodeVerseResetPassword(@RequestParam String email,
                                               @RequestParam String otp,
                                               @RequestParam String newPassword,
                                               RedirectAttributes redirectAttributes) {
        try {
            boolean success = codeVerseUserService.verifyOTPAndResetPassword(email, otp, newPassword);
            if (success) {
                redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", 
                    "Password reset successful! Please login with your new password.");
                return "redirect:/auth/login";
            } else {
                redirectAttributes.addFlashAttribute("codeVerseErrorMessage", 
                    "Invalid or expired OTP");
                return "redirect:/auth/reset-password";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
            return "redirect:/auth/reset-password";
        }
    }
}
```

## File: CodeVerseAdminController.java
```java
package com.codeverse.controller;

import com.codeverse.entity.CodeVerseCategory;
import com.codeverse.entity.CodeVerseUser;
import com.codeverse.service.CodeVerseCategoryService;
import com.codeverse.service.CodeVerseUserService;
import com.codeverse.service.CodeVerseHackathonService;
import com.codeverse.service.CodeVerseRegistrationService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class CodeVerseAdminController {

    private final CodeVerseCategoryService codeVerseCategoryService;
    private final CodeVerseUserService codeVerseUserService;
    private final CodeVerseHackathonService codeVerseHackathonService;
    private final CodeVerseRegistrationService codeVerseRegistrationService;

    @ModelAttribute
    public void addCodeVerseUserToModel(HttpSession session, Model model) {
        CodeVerseUser user = (CodeVerseUser) session.getAttribute("codeVerseUser");
        if (user != null) {
            model.addAttribute("codeVerseCurrentUser", user);
        }
    }

    @GetMapping("/dashboard")
    public String showCodeVerseAdminDashboard(Model model, HttpSession session) {
        if (!isCodeVerseAdmin(session)) {
            return "redirect:/auth/login";
        }
        
        List<CodeVerseCategory> categories = codeVerseCategoryService.getAllCodeVerseCategories();
        List<CodeVerseUser> users = codeVerseUserService.getAllCodeVerseUsers();
        
        model.addAttribute("codeVerseTotalCategories", categories.size());
        model.addAttribute("codeVerseTotalUsers", users.size());
        model.addAttribute("codeVerseTotalHackathons", codeVerseHackathonService.getAllCodeVerseHackathons().size());
        model.addAttribute("codeVersePageTitle", "Admin Dashboard");
        
        return "CodeVerseAdminDashboard";
    }

    @GetMapping("/categories")
    public String showCodeVerseCategories(Model model, HttpSession session) {
        if (!isCodeVerseAdmin(session)) {
            return "redirect:/auth/login";
        }
        
        List<CodeVerseCategory> categories = codeVerseCategoryService.getAllCodeVerseCategories();
        model.addAttribute("codeVerseCategories", categories);
        model.addAttribute("codeVersePageTitle", "Manage Categories");
        return "CodeVerseAdminCategories";
    }

    @PostMapping("/categories/create")
    public String createCodeVerseCategory(@ModelAttribute CodeVerseCategory category,
                                          HttpSession session,
                                          RedirectAttributes redirectAttributes) {
        if (!isCodeVerseAdmin(session)) {
            return "redirect:/auth/login";
        }
        
        try {
            codeVerseCategoryService.createCodeVerseCategory(category);
            redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "Category created successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
        }
        return "redirect:/admin/categories";
    }

    @PostMapping("/categories/update/{id}")
    public String updateCodeVerseCategory(@PathVariable Long id,
                                          @ModelAttribute CodeVerseCategory category,
                                          HttpSession session,
                                          RedirectAttributes redirectAttributes) {
        if (!isCodeVerseAdmin(session)) {
            return "redirect:/auth/login";
        }
        
        try {
            codeVerseCategoryService.updateCodeVerseCategory(id, category);
            redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "Category updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
        }
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/delete/{id}")
    public String deleteCodeVerseCategory(@PathVariable Long id,
                                          HttpSession session,
                                          RedirectAttributes redirectAttributes) {
        if (!isCodeVerseAdmin(session)) {
            return "redirect:/auth/login";
        }
        
        try {
            codeVerseCategoryService.deleteCodeVerseCategory(id);
            redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "Category deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", "Cannot delete category with existing hackathons");
        }
        return "redirect:/admin/categories";
    }

    @GetMapping("/categories/toggle/{id}")
    public String toggleCodeVerseCategoryStatus(@PathVariable Long id,
                                                HttpSession session,
                                                RedirectAttributes redirectAttributes) {
        if (!isCodeVerseAdmin(session)) {
            return "redirect:/auth/login";
        }
        
        try {
            codeVerseCategoryService.toggleCodeVerseCategoryStatus(id);
            redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "Category status updated!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
        }
        return "redirect:/admin/categories";
    }

    @GetMapping("/users")
    public String showCodeVerseUsers(Model model, HttpSession session) {
        if (!isCodeVerseAdmin(session)) {
            return "redirect:/auth/login";
        }
        
        List<CodeVerseUser> users = codeVerseUserService.getAllCodeVerseUsers();
        model.addAttribute("codeVerseUsers", users);
        model.addAttribute("codeVersePageTitle", "Manage Users");
        return "CodeVerseAdminUsers";
    }

    @GetMapping("/users/toggle/{id}")
    public String toggleCodeVerseUserStatus(@PathVariable Long id,
                                           HttpSession session,
                                           RedirectAttributes redirectAttributes) {
        if (!isCodeVerseAdmin(session)) {
            return "redirect:/auth/login";
        }
        
        try {
            codeVerseUserService.toggleCodeVerseUserStatus(id);
            redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "User status updated!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
        }
        return "redirect:/admin/users";
    }

    private boolean isCodeVerseAdmin(HttpSession session) {
        String userType = (String) session.getAttribute("codeVerseUserType");
        return "ADMIN".equals(userType);
    }
}
```

## File: CodeVerseOrganizerController.java
```java
package com.codeverse.controller;

import com.codeverse.entity.CodeVerseUser;
import com.codeverse.entity.CodeVerseHackathon;
import com.codeverse.entity.CodeVerseCategory;
import com.codeverse.entity.CodeVerseRegistration;
import com.codeverse.service.CodeVerseHackathonService;
import com.codeverse.service.CodeVerseCategoryService;
import com.codeverse.service.CodeVerseRegistrationService;
import com.codeverse.service.CodeVerseUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/organizer")
@RequiredArgsConstructor
public class CodeVerseOrganizerController {

    private final CodeVerseHackathonService codeVerseHackathonService;
    private final CodeVerseCategoryService codeVerseCategoryService;
    private final CodeVerseRegistrationService codeVerseRegistrationService;
    private final CodeVerseUserService codeVerseUserService;

    @ModelAttribute
    public void addCodeVerseUserToModel(HttpSession session, Model model) {
        CodeVerseUser user = (CodeVerseUser) session.getAttribute("codeVerseUser");
        if (user != null) {
            model.addAttribute("codeVerseCurrentUser", user);
        }
    }

    @GetMapping("/dashboard")
    public String showCodeVerseOrganizerDashboard(Model model, HttpSession session) {
        if (!isCodeVerseOrganizer(session)) {
            return "redirect:/auth/login";
        }
        
        Long organizerId = (Long) session.getAttribute("codeVerseUserId");
        List<CodeVerseHackathon> myHackathons = codeVerseHackathonService.getCodeVerseHackathonsByOrganizer(organizerId);
        
        model.addAttribute("codeVerseMyHackathons", myHackathons);
        model.addAttribute("codeVerseTotalHackathons", myHackathons.size());
        model.addAttribute("codeVersePageTitle", "Organizer Dashboard");
        
        return "CodeVerseOrganizerDashboard";
    }

    @GetMapping("/hackathons")
    public String showCodeVerseHackathons(Model model, HttpSession session) {
        if (!isCodeVerseOrganizer(session)) {
            return "redirect:/auth/login";
        }
        
        Long organizerId = (Long) session.getAttribute("codeVerseUserId");
        List<CodeVerseHackathon> hackathons = codeVerseHackathonService.getCodeVerseHackathonsByOrganizer(organizerId);
        
        model.addAttribute("codeVerseHackathons", hackathons);
        model.addAttribute("codeVersePageTitle", "My Hackathons");
        return "CodeVerseOrganizerHackathons";
    }

    @GetMapping("/hackathons/create")
    public String showCodeVerseCreateHackathonForm(Model model, HttpSession session) {
        if (!isCodeVerseOrganizer(session)) {
            return "redirect:/auth/login";
        }
        
        List<CodeVerseCategory> categories = codeVerseCategoryService.getAllActiveCodeVerseCategories();
        model.addAttribute("codeVerseCategories", categories);
        model.addAttribute("codeVersePageTitle", "Create Hackathon");
        return "CodeVerseOrganizerCreate";
    }

    @PostMapping("/hackathons/create")
    public String createCodeVerseHackathon(@RequestParam String hackathonTitle,
                                          @RequestParam String hackathonDescription,
                                          @RequestParam Long categoryId,
                                          @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate eventDate,
                                          @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime eventTime,
                                          @RequestParam Integer durationHours,
                                          @RequestParam String venueLocation,
                                          @RequestParam CodeVerseHackathon.VenueType venueType,
                                          @RequestParam Integer maxSlots,
                                          @RequestParam(required = false) String prizePool,
                                          @RequestParam(required = false) String registrationFee,
                                          @RequestParam(required = false) String skillsRequired,
                                          HttpSession session,
                                          RedirectAttributes redirectAttributes) {
        if (!isCodeVerseOrganizer(session)) {
            return "redirect:/auth/login";
        }
        
        try {
            Long organizerId = (Long) session.getAttribute("codeVerseUserId");
            Optional<CodeVerseUser> organizer = codeVerseUserService.getCodeVerseUserById(organizerId);
            Optional<CodeVerseCategory> category = codeVerseCategoryService.getCodeVerseCategoryById(categoryId);
            
            if (organizer.isEmpty() || category.isEmpty()) {
                throw new RuntimeException("Invalid organizer or category");
            }
            
            CodeVerseHackathon hackathon = new CodeVerseHackathon();
            hackathon.setHackathonTitle(hackathonTitle);
            hackathon.setHackathonDescription(hackathonDescription);
            hackathon.setOrganizer(organizer.get());
            hackathon.setCategory(category.get());
            hackathon.setEventDate(eventDate);
            hackathon.setEventTime(eventTime);
            hackathon.setDurationHours(durationHours);
            hackathon.setVenueLocation(venueLocation);
            hackathon.setVenueType(venueType);
            hackathon.setMaxSlots(maxSlots);
            hackathon.setAvailableSlots(maxSlots);
            hackathon.setSkillsRequired(skillsRequired);
            
            codeVerseHackathonService.createCodeVerseHackathon(hackathon);
            redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "Hackathon created successfully!");
            return "redirect:/organizer/hackathons";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
            return "redirect:/organizer/hackathons/create";
        }
    }

    @GetMapping("/hackathons/delete/{id}")
    public String deleteCodeVerseHackathon(@PathVariable Long id,
                                          HttpSession session,
                                          RedirectAttributes redirectAttributes) {
        if (!isCodeVerseOrganizer(session)) {
            return "redirect:/auth/login";
        }
        
        try {
            Long organizerId = (Long) session.getAttribute("codeVerseUserId");
            Optional<CodeVerseHackathon> hackathon = codeVerseHackathonService.getCodeVerseHackathonById(id);
            
            if (hackathon.isPresent() && hackathon.get().getOrganizer().getUserId().equals(organizerId)) {
                codeVerseHackathonService.deleteCodeVerseHackathon(id);
                redirectAttributes.addFlashAttribute("codeVerseSuccessMessage", "Hackathon deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("codeVerseErrorMessage", "Unauthorized action");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("codeVerseErrorMessage", e.getMessage());
        }
        return "redirect:/organizer/hackathons";
    }

    @GetMapping("/registrations/{hackathonId}")
    public String viewCodeVerseRegistrations(@PathVariable Long hackathonId,
                                            Model model,
                                            HttpSession session) {
        if (!isCodeVerseOrganizer(session)) {
            return "redirect:/auth/login";
        }
        
        Long organizerId = (Long) session.getAttribute("codeVerseUserId");
        Optional<CodeVerseHackathon> hackathon = codeVerseHackathonService.getCodeVerseHackathonById(hackathonId);
        
        if (hackathon.isEmpty() || !hackathon.get().getOrganizer().getUserId().equals(organizerId)) {
            return "redirect:/organizer/hackathons";
        }
        
        List<CodeVerseRegistration> registrations = codeVerseRegistrationService.getCodeVerseRegistrationsByHackathon(hackathonId);
        
        model.addAttribute("codeVerseHackathon", hackathon.get());
        model.addAttribute("codeVerseRegistrations", registrations);
        model.addAttribute("codeVersePageTitle", "Registrations");
        return "CodeVerseOrganizerRegistrations";
    }

    private boolean isCodeVerseOrganizer(HttpSession session) {
        String userType = (String) session.getAttribute("codeVerseUserType");
        return "ORGANIZER".equals(userType) || "ADMIN".equals(userType);
    }
}
```

## Continued in next file...
