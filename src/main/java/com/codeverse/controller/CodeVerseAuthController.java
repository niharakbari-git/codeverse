package com.codeverse.controller;

import com.codeverse.entity.CodeVerseUser;
import com.codeverse.service.CodeVerseUserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class CodeVerseAuthController {

    private final CodeVerseUserService codeVerseUserService;

    /**
     * Display login page
     */
    @GetMapping("/login")
    public String showLoginPage(Model model) {
        try {
            return "codeverse-login";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while loading the login page");
            return "error-page";
        }
    }

    /**
     * Login endpoint - handled by Spring Security
     * Redirects to POST /codeverse/login
     */
    @PostMapping("/login")
    public String handleLogin(@RequestParam String email, @RequestParam String password, 
                            HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Optional<CodeVerseUser> user = codeVerseUserService.authenticateUser(email, password);
            
            if (user.isPresent()) {
                CodeVerseUser loggedInUser = user.get();
                session.setAttribute("userId", loggedInUser.getUserId());
                session.setAttribute("username", loggedInUser.getUsername());
                session.setAttribute("userType", loggedInUser.getUserType().getUserTypeName());
                session.setAttribute("email", loggedInUser.getEmail());
                session.setAttribute("fullName", loggedInUser.getFullName());
                
                redirectAttributes.addFlashAttribute("success", "Login successful!");
                return "redirect:/dashboard";
            } else {
                model.addAttribute("error", "Invalid email or password");
                return "codeverse-login";
            }
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred during login: " + e.getMessage());
            return "codeverse-login";
        }
    }

    /**
     * Display registration form
     */
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        try {
            model.addAttribute("user", new CodeVerseUser());
            return "codeverse-register";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while loading the registration page");
            return "error-page";
        }
    }

    /**
     * Handle user registration
     */
    @PostMapping("/register")
    public String registerUser(CodeVerseUser user, @RequestParam String userType, 
                             RedirectAttributes redirectAttributes) {
        try {
            if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Username is required");
                return "redirect:/register";
            }
            
            if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Email is required");
                return "redirect:/register";
            }
            
            if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Password is required");
                return "redirect:/register";
            }
            
            if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Full name is required");
                return "redirect:/register";
            }
            
            codeVerseUserService.registerUser(user, userType);
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please log in.");
            return "redirect:/login";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/register";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred during registration: " + e.getMessage());
            return "redirect:/register";
        }
    }

    /**
     * Display forgot password form
     */
    @GetMapping("/forgot-password")
    public String showForgotPasswordForm(Model model) {
        try {
            return "codeverse-forgot-password";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while loading the forgot password page");
            return "error-page";
        }
    }

    /**
     * Handle forgot password - send OTP
     */
    @PostMapping("/forgot-password")
    public String handleForgotPassword(@RequestParam String email, 
                                      RedirectAttributes redirectAttributes) {
        try {
            if (email == null || email.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Email is required");
                return "redirect:/forgot-password";
            }
            
            boolean sent = codeVerseUserService.initiatePasswordReset(email);
            
            if (sent) {
                redirectAttributes.addFlashAttribute("success", "OTP has been sent to your email!");
                return "redirect:/reset-password?email=" + email;
            } else {
                redirectAttributes.addFlashAttribute("error", "Email not found in our system");
                return "redirect:/forgot-password";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/forgot-password";
        }
    }

    /**
     * Display reset password form
     */
    @GetMapping("/reset-password")
    public String showResetPasswordForm(@RequestParam(required = false) String email, Model model) {
        try {
            if (email != null) {
                model.addAttribute("email", email);
            }
            return "codeverse-reset-password";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while loading the reset password page");
            return "error-page";
        }
    }

    /**
     * Handle password reset with OTP
     */
    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String email, @RequestParam String otp, 
                               @RequestParam String newPassword, @RequestParam String confirmPassword,
                               RedirectAttributes redirectAttributes) {
        try {
            if (email == null || email.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Email is required");
                return "redirect:/forgot-password";
            }
            
            if (otp == null || otp.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "OTP is required");
                return "redirect:/reset-password?email=" + email;
            }
            
            if (newPassword == null || newPassword.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "New password is required");
                return "redirect:/reset-password?email=" + email;
            }
            
            if (!newPassword.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "Passwords do not match");
                return "redirect:/reset-password?email=" + email;
            }
            
            boolean resetSuccess = codeVerseUserService.resetPassword(email, otp, newPassword);
            
            if (resetSuccess) {
                redirectAttributes.addFlashAttribute("success", "Password has been reset successfully! Please log in.");
                return "redirect:/login";
            } else {
                redirectAttributes.addFlashAttribute("error", "Invalid OTP or OTP has expired");
                return "redirect:/reset-password?email=" + email;
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/reset-password";
        }
    }

    /**
     * Dashboard - redirect based on user role
     */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || userType == null) {
                redirectAttributes.addFlashAttribute("error", "Please log in to continue");
                return "redirect:/login";
            }
            
            String userTypeStr = userType.toString();
            
            if ("Admin".equalsIgnoreCase(userTypeStr)) {
                return "redirect:/admin/dashboard";
            } else if ("Organizer".equalsIgnoreCase(userTypeStr)) {
                return "redirect:/organizer/dashboard";
            } else if ("Participant".equalsIgnoreCase(userTypeStr)) {
                return "redirect:/participant/dashboard";
            } else {
                redirectAttributes.addFlashAttribute("error", "Unknown user role");
                return "redirect:/login";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/login";
        }
    }

    /**
     * Logout endpoint
     */
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            session.invalidate();
            redirectAttributes.addFlashAttribute("success", "You have been logged out successfully");
            return "redirect:/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred during logout: " + e.getMessage());
            return "redirect:/login";
        }
    }
}