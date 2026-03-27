package com.codeverse.repository;

import com.codeverse.entity.CodeVerseUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CodeVerseUserRepository extends JpaRepository<CodeVerseUser, Long> {

    Optional<CodeVerseUser> findByUsername(String username);

    Optional<CodeVerseUser> findByEmail(String email);

    @Query("SELECT u FROM CodeVerseUser u WHERE u.email = ?1 AND u.isActive = true")
    Optional<CodeVerseUser> findActiveUserByEmail(String email);

    @Query("SELECT u FROM CodeVerseUser u WHERE u.userType.userTypeName = ?1")
    List<CodeVerseUser> findByUserTypeName(String userTypeName);

    @Query("SELECT u FROM CodeVerseUser u WHERE u.isActive = true")
    List<CodeVerseUser> findAllActiveUsers();

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);
}
