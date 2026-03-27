package com.codeverse.repository;

import com.codeverse.entity.CodeVerseCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CodeVerseCategoryRepository extends JpaRepository<CodeVerseCategory, Long> {

    Optional<CodeVerseCategory> findByCategoryName(String categoryName);

    @Query("SELECT c FROM CodeVerseCategory c WHERE c.isActive = true ORDER BY c.categoryName")
    List<CodeVerseCategory> findAllActiveCategories();

    boolean existsByCategoryName(String categoryName);
}
