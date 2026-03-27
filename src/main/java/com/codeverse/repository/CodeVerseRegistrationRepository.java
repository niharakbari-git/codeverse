package com.codeverse.repository;

import com.codeverse.entity.CodeVerseRegistration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CodeVerseRegistrationRepository extends JpaRepository<CodeVerseRegistration, Long> {

    Optional<CodeVerseRegistration> findByRegistrationCode(String registrationCode);

    @Query("SELECT r FROM CodeVerseRegistration r WHERE r.participant.userId = :userId ORDER BY r.registeredAt DESC")
    List<CodeVerseRegistration> findByParticipantId(@Param("userId") Long userId);

    @Query("SELECT r FROM CodeVerseRegistration r WHERE r.hackathon.hackathonId = :hackathonId")
    List<CodeVerseRegistration> findByHackathonId(@Param("hackathonId") Long hackathonId);

    @Query("SELECT COUNT(r) > 0 FROM CodeVerseRegistration r WHERE r.hackathon.hackathonId = :hackathonId AND r.participant.userId = :participantId")
    boolean existsByHackathonIdAndParticipantId(@Param("hackathonId") Long hackathonId, @Param("participantId") Long participantId);
}
