package com.codeverse.controller;

import com.codeverse.entity.CodeVerseCategory;
import com.codeverse.entity.CodeVerseUser;
import com.codeverse.service.CodeVerseCategoryService;
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
@RequestMapping("/admin")
@RequiredArgsConstructor
public class CodeVerseAdminController {

    private final CodeVerseCategoryService codeverseservice;
    private final CodeVerseUserService codeVerseUserService;

    /**
     * Admin dashboard
     */
    @GetMapping("/dashboard")
    public String showAdminDashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userId = session.getAttribute("userId");
            Object userType = session.getAttribute("userType");
            
            if (userId == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            // Add dashboard statistics
            List<CodeVerseCategory> categories = codeverseservice.findAllActiveCategories();
            List<CodeVerseUser> users = codeVerseUserService.findAllUsers();
            
            model.addAttribute("totalCategories", categories.size());
            model.addAttribute("totalUsers", users.size());
            model.addAttribute("adminName", session.getAttribute("fullName"));
            
            return "codeverse-admin-dashboard";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/login";
        }
    }

    /**
     * List all categories
     */
    @GetMapping("/categories")
    public String listCategories(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            List<CodeVerseCategory> categories = codeverseservice.findAllCategories();
            model.addAttribute("categories", categories);
            
            return "codeverse-admin-categories";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while fetching categories: " + e.getMessage());
            return "codeverse-admin-categories";
        }
    }

    /**
     * Show create category form
     */
    @GetMapping("/categories/new")
    public String showCreateCategoryForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            model.addAttribute("category", new CodeVerseCategory());
            return "codeverse-admin-category-form";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred: " + e.getMessage());
            return "error-page";
        }
    }

    /**
     * Create new category
     */
    @PostMapping("/categories")
    public String createCategory(CodeVerseCategory category, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            if (category.getCategoryName() == null || category.getCategoryName().trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Category name is required");
                return "redirect:/admin/categories/new";
            }
            
            codeverseservice.createCategory(category);
            redirectAttributes.addFlashAttribute("success", "Category created successfully!");
            return "redirect:/admin/categories";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/categories/new";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/admin/categories/new";
        }
    }

    /**
     * Show edit category form
     */
    @GetMapping("/categories/{id}/edit")
    public String showEditCategoryForm(@PathVariable Long id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            Optional<CodeVerseCategory> category = codeverseservice.findById(id);
            if (category.isPresent()) {
                model.addAttribute("category", category.get());
                return "codeverse-admin-category-form";
            } else {
                redirectAttributes.addFlashAttribute("error", "Category not found");
                return "redirect:/admin/categories";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/admin/categories";
        }
    }

    /**
     * Update category
     */
    @PostMapping("/categories/{id}")
    public String updateCategory(@PathVariable Long id, CodeVerseCategory updatedCategory, 
                                HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            codeverseservice.updateCategory(id, updatedCategory);
            redirectAttributes.addFlashAttribute("success", "Category updated successfully!");
            return "redirect:/admin/categories";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/categories/" + id + "/edit";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/admin/categories/" + id + "/edit";
        }
    }

    /**
     * Delete category
     */
    @PostMapping("/categories/{id}/delete")
    public String deleteCategory(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            codeverseservice.deleteCategory(id);
            redirectAttributes.addFlashAttribute("success", "Category deleted successfully!");
            return "redirect:/admin/categories";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/categories";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/admin/categories";
        }
    }

    /**
     * List all users
     */
    @GetMapping("/users")
    public String listUsers(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            List<CodeVerseUser> users = codeVerseUserService.findAllUsers();
            model.addAttribute("users", users);
            
            return "codeverse-admin-users";
        } catch (Exception e) {
            model.addAttribute("error", "An error occurred while fetching users: " + e.getMessage());
            return "codeverse-admin-users";
        }
    }

    /**
     * Toggle user status (activate/deactivate)
     */
    @PostMapping("/users/{id}/toggle-status")
    public String toggleUserStatus(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Object userType = session.getAttribute("userType");
            if (userType == null || !("Admin".equalsIgnoreCase(userType.toString()))) {
                redirectAttributes.addFlashAttribute("error", "Access denied! Admin only.");
                return "redirect:/login";
            }
            
            codeVerseUserService.toggleUserStatus(id);
            redirectAttributes.addFlashAttribute("success", "User status toggled successfully!");
            return "redirect:/admin/users";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/users";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "An error occurred: " + e.getMessage());
            return "redirect:/admin/users";
        }
    }
}