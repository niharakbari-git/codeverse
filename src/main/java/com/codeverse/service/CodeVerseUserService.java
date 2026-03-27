package com.codeverse.service;

import com.codeverse.entity.CodeVerseUser;
import com.codeverse.entity.CodeVerseUserType;
import com.codeverse.repository.CodeVerseUserRepository;
import com.codeverse.repository.CodeVerseUserTypeRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class CodeVerseUserService {

    private final CodeVerseUserRepository codeVerseUserRepository;
    private final CodeVerseUserTypeRepository codeVerseUserTypeRepository;
    private final PasswordEncoder passwordEncoder;
    private final CodeVerseMailService codeVerseMailService;

    @Transactional
    public CodeVerseUser registerUser(CodeVerseUser user, String userTypeName) {
        if (codeVerseUserRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already exists!");
        }
        if (codeVerseUserRepository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("Username already exists!");
        }

        CodeVerseUserType userType = codeVerseUserTypeRepository.findByUserTypeName(userTypeName)
                .orElseThrow(() -> new RuntimeException("User type not found"));

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setUserType(userType);
        user.setIsActive(true);
        user.setIsVerified(true);

        CodeVerseUser savedUser = codeVerseUserRepository.save(user);
        codeVerseMailService.sendRegistrationSuccessMail(savedUser);
        
        return savedUser;
    }

    public Optional<CodeVerseUser> authenticateUser(String email, String password) {
        Optional<CodeVerseUser> userOpt = codeVerseUserRepository.findActiveUserByEmail(email);
        if (userOpt.isPresent() && passwordEncoder.matches(password, userOpt.get().getPassword())) {
            return userOpt;
        }
        return Optional.empty();
    }

    @Transactional
    public boolean initiatePasswordReset(String email) {
        Optional<CodeVerseUser> userOpt = codeVerseUserRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            CodeVerseUser user = userOpt.get();
            String otp = String.format("%06d", new Random().nextInt(999999));
            user.setResetOtp(otp);
            user.setOtpExpiry(LocalDateTime.now().plusMinutes(15));
            codeVerseUserRepository.save(user);
            
            codeVerseMailService.sendPasswordResetOTP(user, otp);
            return true;
        }
        return false;
    }

    @Transactional
    public boolean resetPassword(String email, String otp, String newPassword) {
        Optional<CodeVerseUser> userOpt = codeVerseUserRepository.findByEmail(email);
        if (userOpt.isPresent()) {
            CodeVerseUser user = userOpt.get();
            if (user.getResetOtp() != null && user.getResetOtp().equals(otp) 
                && user.getOtpExpiry().isAfter(LocalDateTime.now())) {
                user.setPassword(passwordEncoder.encode(newPassword));
                user.setResetOtp(null);
                user.setOtpExpiry(null);
                codeVerseUserRepository.save(user);
                return true;
            }
        }
        return false;
    }

    @SuppressWarnings("null")
    public Optional<CodeVerseUser> findById(Long userId) {
        return codeVerseUserRepository.findById(Long.valueOf(userId));
    }

    public List<CodeVerseUser> findAllUsers() {
        return codeVerseUserRepository.findAllActiveUsers();
    }

    public List<CodeVerseUser> findUsersByType(String userTypeName) {
        return codeVerseUserRepository.findByUserTypeName(userTypeName);
    }

    @Transactional
    @SuppressWarnings("null")
    public void toggleUserStatus(Long userId) {
        CodeVerseUser user = codeVerseUserRepository.findById(Long.valueOf(userId))
                .orElseThrow(() -> new RuntimeException("User not found"));
        user.setIsActive(!user.getIsActive());
        codeVerseUserRepository.save(user);
    }
}
