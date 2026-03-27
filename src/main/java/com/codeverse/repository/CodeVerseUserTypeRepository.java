package com.codeverse.repository;

import com.codeverse.entity.CodeVerseUserType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CodeVerseUserTypeRepository extends JpaRepository<CodeVerseUserType, Integer> {

    Optional<CodeVerseUserType> findByUserTypeName(String userTypeName);
}
