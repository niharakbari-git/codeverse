package com.codeverse.service;

import com.codeverse.entity.CodeVerseCategory;
import com.codeverse.repository.CodeVerseCategoryRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CodeVerseCategoryService {

    private final CodeVerseCategoryRepository codeverseRepository;

    /**
     * Retrieve all active categories
     */
    public List<CodeVerseCategory> findAllActiveCategories() {
        return codeverseRepository.findAllActiveCategories();
    }

    /**
     * Create a new category
     */
    @Transactional
    public CodeVerseCategory createCategory(CodeVerseCategory category) {
        if (category.getCategoryName() == null || category.getCategoryName().trim().isEmpty()) {
            throw new RuntimeException("Category name cannot be empty");
        }

        if (codeverseRepository.existsByCategoryName(category.getCategoryName().trim())) {
            throw new RuntimeException("Category with name '" + category.getCategoryName() + "' already exists");
        }

        category.setIsActive(true);
        category.setCreatedAt(LocalDateTime.now());
        category.setUpdatedAt(LocalDateTime.now());

        return codeverseRepository.save(category);
    }

    /**
     * Update an existing category
     */
    @Transactional
    @SuppressWarnings("null")
    public CodeVerseCategory updateCategory(Long categoryId, CodeVerseCategory updatedCategory) {
        CodeVerseCategory category = codeverseRepository.findById(Long.valueOf(categoryId))
                .orElseThrow(() -> new RuntimeException("Category not found with ID: " + categoryId));

        // Check if new category name already exists (if it's different from current)
        if (updatedCategory.getCategoryName() != null 
                && !updatedCategory.getCategoryName().equals(category.getCategoryName())
                && codeverseRepository.existsByCategoryName(updatedCategory.getCategoryName().trim())) {
            throw new RuntimeException("Category with name '" + updatedCategory.getCategoryName() + "' already exists");
        }

        if (updatedCategory.getCategoryName() != null && !updatedCategory.getCategoryName().trim().isEmpty()) {
            category.setCategoryName(updatedCategory.getCategoryName().trim());
        }

        if (updatedCategory.getCategoryDescription() != null) {
            category.setCategoryDescription(updatedCategory.getCategoryDescription());
        }

        if (updatedCategory.getCategoryIcon() != null) {
            category.setCategoryIcon(updatedCategory.getCategoryIcon());
        }

        if (updatedCategory.getIsActive() != null) {
            category.setIsActive(updatedCategory.getIsActive());
        }

        category.setUpdatedAt(LocalDateTime.now());

        return codeverseRepository.save(category);
    }

    /**
     * Delete a category (soft delete by setting isActive to false)
     */
    @Transactional
    @SuppressWarnings("null")
    public void deleteCategory(Long categoryId) {
        CodeVerseCategory category = codeverseRepository.findById(Long.valueOf(categoryId))
                .orElseThrow(() -> new RuntimeException("Category not found with ID: " + categoryId));

        category.setIsActive(false);
        category.setUpdatedAt(LocalDateTime.now());

        codeverseRepository.save(category);
    }

    /**
     * Find category by ID
     */
    @SuppressWarnings("null")
    public Optional<CodeVerseCategory> findById(Long categoryId) {
        return codeverseRepository.findById(Long.valueOf(categoryId));
    }

    /**
     * Find category by name
     */
    public Optional<CodeVerseCategory> findByCategoryName(String categoryName) {
        return codeverseRepository.findByCategoryName(categoryName);
    }

    /**
     * Retrieve all categories (including inactive)
     */
    public List<CodeVerseCategory> findAllCategories() {
        return codeverseRepository.findAll();
    }
}
