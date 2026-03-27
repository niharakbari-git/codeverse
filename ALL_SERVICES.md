# CodeVerse - Complete Service Layer

## File: CodeVerseUserService.java
```java
package com.codeverse.service;

import com.codeverse.entity.CodeVerseUser;
import com.codeverse.entity.CodeVerseUserType;
import com.codeverse.repository.CodeVerseUserRepository;
import com.codeverse.repository.CodeVerseUserTypeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
@RequiredArgsConstructor
@Transactional
public class CodeVerseUserService {

    private final CodeVerseUserRepository codeVerseUserRepository;
    private final CodeVerseUserTypeRepository codeVerseUserTypeRepository;
    private final BCryptPasswordEncoder codeVersePasswordEncoder;
    private final CodeVerseMailService codeVerseMailService;

    public CodeVerseUser registerCodeVerseUser(CodeVerseUser user, String userTypeName) {
        Optional<CodeVerseUserType> userType = codeVerseUserTypeRepository.findByUserTypeName(userTypeName);
        if (userType.isEmpty()) {
            throw new RuntimeException("CodeVerse User Type not found: " + userTypeName);
        }
        
        if (codeVerseUserRepository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("CodeVerse Username already exists");
        }
        
        if (codeVerseUserRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("CodeVerse Email already exists");
        }
        
        user.setUserType(userType.get());
        user.setPassword(codeVersePasswordEncoder.encode(user.getPassword()));
        user.setIsActive(true);
        user.setIsVerified(false);
        
        CodeVerseUser savedUser = codeVerseUserRepository.save(user);
        
        // Send registration success email
        codeVerseMailService.sendRegistrationSuccessEmail(savedUser);
        
        return savedUser;
    }

    public Optional<CodeVerseUser> authenticateCodeVerseUser(String username, String password) {
        Optional<CodeVerseUser> user = codeVerseUserRepository.findByUsername(username);
        
        if (user.isPresent() && codeVersePasswordEncoder.matches(password, user.get().getPassword())) {
            if (!user.get().getIsActive()) {
                throw new RuntimeException("CodeVerse Account is inactive");
            }
            return user;
        }
        
        return Optional.empty();
    }

    public void generatePasswordResetOTP(String email) {
        Optional<CodeVerseUser> user = codeVerseUserRepository.findByEmail(email);
        
        if (user.isEmpty()) {
            throw new RuntimeException("CodeVerse Email not found");
        }
        
        String otp = String.format("%06d", new Random().nextInt(1000000));
        CodeVerseUser codeVerseUser = user.get();
        codeVerseUser.setResetOtp(otp);
        codeVerseUser.setOtpExpiry(LocalDateTime.now().plusMinutes(15));
        
        codeVerseUserRepository.save(codeVerseUser);
        codeVerseMailService.sendPasswordResetOTP(codeVerseUser, otp);
    }

    public boolean verifyOTPAndResetPassword(String email, String otp, String newPassword) {
        Optional<CodeVerseUser> user = codeVerseUserRepository.findByEmailAndResetOtp(email, otp);
        
        if (user.isEmpty()) {
            return false;
        }
        
        CodeVerseUser codeVerseUser = user.get();
        
        if (codeVerseUser.getOtpExpiry() == null || LocalDateTime.now().isAfter(codeVerseUser.getOtpExpiry())) {
            return false;
        }
        
        codeVerseUser.setPassword(codeVersePasswordEncoder.encode(newPassword));
        codeVerseUser.setResetOtp(null);
        codeVerseUser.setOtpExpiry(null);
        
        codeVerseUserRepository.save(codeVerseUser);
        return true;
    }

    public List<CodeVerseUser> getAllCodeVerseUsers() {
        return codeVerseUserRepository.findAll();
    }

    public List<CodeVerseUser> getCodeVerseUsersByType(String userTypeName) {
        return codeVerseUserRepository.findByUserTypeName(userTypeName);
    }

    public Optional<CodeVerseUser> getCodeVerseUserById(Long userId) {
        return codeVerseUserRepository.findById(userId);
    }

    public Optional<CodeVerseUser> getCodeVerseUserByUsername(String username) {
        return codeVerseUserRepository.findByUsername(username);
    }

    public void toggleCodeVerseUserStatus(Long userId) {
        Optional<CodeVerseUser> user = codeVerseUserRepository.findById(userId);
        if (user.isPresent()) {
            CodeVerseUser codeVerseUser = user.get();
            codeVerseUser.setIsActive(!codeVerseUser.getIsActive());
            codeVerseUserRepository.save(codeVerseUser);
        }
    }

    public void deleteCodeVerseUser(Long userId) {
        codeVerseUserRepository.deleteById(userId);
    }
}
```

## File: CodeVerseCategoryService.java
```java
package com.codeverse.service;

import com.codeverse.entity.CodeVerseCategory;
import com.codeverse.repository.CodeVerseCategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CodeVerseCategoryService {

    private final CodeVerseCategoryRepository codeVerseCategoryRepository;

    public CodeVerseCategory createCodeVerseCategory(CodeVerseCategory category) {
        if (codeVerseCategoryRepository.existsByCategoryName(category.getCategoryName())) {
            throw new RuntimeException("CodeVerse Category already exists");
        }
        return codeVerseCategoryRepository.save(category);
    }

    public CodeVerseCategory updateCodeVerseCategory(Long categoryId, CodeVerseCategory category) {
        Optional<CodeVerseCategory> existing = codeVerseCategoryRepository.findById(categoryId);
        if (existing.isEmpty()) {
            throw new RuntimeException("CodeVerse Category not found");
        }
        
        CodeVerseCategory codeVerseCategory = existing.get();
        codeVerseCategory.setCategoryName(category.getCategoryName());
        codeVerseCategory.setCategoryDescription(category.getCategoryDescription());
        codeVerseCategory.setCategoryIcon(category.getCategoryIcon());
        codeVerseCategory.setIsActive(category.getIsActive());
        
        return codeVerseCategoryRepository.save(codeVerseCategory);
    }

    public List<CodeVerseCategory> getAllCodeVerseCategories() {
        return codeVerseCategoryRepository.findAll();
    }

    public List<CodeVerseCategory> getAllActiveCodeVerseCategories() {
        return codeVerseCategoryRepository.findAllActiveCategories();
    }

    public Optional<CodeVerseCategory> getCodeVerseCategoryById(Long categoryId) {
        return codeVerseCategoryRepository.findById(categoryId);
    }

    public void deleteCodeVerseCategory(Long categoryId) {
        codeVerseCategoryRepository.deleteById(categoryId);
    }

    public void toggleCodeVerseCategoryStatus(Long categoryId) {
        Optional<CodeVerseCategory> category = codeVerseCategoryRepository.findById(categoryId);
        if (category.isPresent()) {
            CodeVerseCategory codeVerseCategory = category.get();
            codeVerseCategory.setIsActive(!codeVerseCategory.getIsActive());
            codeVerseCategoryRepository.save(codeVerseCategory);
        }
    }
}
```

## File: CodeVerseHackathonService.java
```java
package com.codeverse.service;

import com.codeverse.entity.CodeVerseHackathon;
import com.codeverse.entity.CodeVerseHackathon.HackathonStatus;
import com.codeverse.repository.CodeVerseHackathonRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CodeVerseHackathonService {

    private final CodeVerseHackathonRepository codeVerseHackathonRepository;

    public CodeVerseHackathon createCodeVerseHackathon(CodeVerseHackathon hackathon) {
        if (hackathon.getAvailableSlots() == null) {
            hackathon.setAvailableSlots(hackathon.getMaxSlots());
        }
        return codeVerseHackathonRepository.save(hackathon);
    }

    public CodeVerseHackathon updateCodeVerseHackathon(Long hackathonId, CodeVerseHackathon hackathon) {
        Optional<CodeVerseHackathon> existing = codeVerseHackathonRepository.findById(hackathonId);
        if (existing.isEmpty()) {
            throw new RuntimeException("CodeVerse Hackathon not found");
        }
        
        CodeVerseHackathon codeVerseHackathon = existing.get();
        codeVerseHackathon.setHackathonTitle(hackathon.getHackathonTitle());
        codeVerseHackathon.setHackathonDescription(hackathon.getHackathonDescription());
        codeVerseHackathon.setCategory(hackathon.getCategory());
        codeVerseHackathon.setEventDate(hackathon.getEventDate());
        codeVerseHackathon.setEventTime(hackathon.getEventTime());
        codeVerseHackathon.setDurationHours(hackathon.getDurationHours());
        codeVerseHackathon.setVenueLocation(hackathon.getVenueLocation());
        codeVerseHackathon.setVenueType(hackathon.getVenueType());
        codeVerseHackathon.setMaxSlots(hackathon.getMaxSlots());
        codeVerseHackathon.setPrizePool(hackathon.getPrizePool());
        codeVerseHackathon.setRegistrationFee(hackathon.getRegistrationFee());
        codeVerseHackathon.setSkillsRequired(hackathon.getSkillsRequired());
        codeVerseHackathon.setStatus(hackathon.getStatus());
        
        return codeVerseHackathonRepository.save(codeVerseHackathon);
    }

    public List<CodeVerseHackathon> getAllCodeVerseHackathons() {
        return codeVerseHackathonRepository.findAll();
    }

    public List<CodeVerseHackathon> getAllActiveCodeVerseHackathons() {
        return codeVerseHackathonRepository.findAllActiveHackathons();
    }

    public List<CodeVerseHackathon> getCodeVerseHackathonsByOrganizer(Long organizerId) {
        return codeVerseHackathonRepository.findByOrganizerId(organizerId);
    }

    public List<CodeVerseHackathon> getCodeVerseHackathonsByCategory(Long categoryId) {
        return codeVerseHackathonRepository.findByCategoryId(categoryId);
    }

    public List<CodeVerseHackathon> getUpcomingCodeVerseHackathons() {
        return codeVerseHackathonRepository.findUpcomingHackathons(LocalDate.now());
    }

    public List<CodeVerseHackathon> getCodeVerseHackathonsWithSlots() {
        return codeVerseHackathonRepository.findHackathonsWithAvailableSlots();
    }

    public List<CodeVerseHackathon> searchCodeVerseHackathons(String keyword) {
        return codeVerseHackathonRepository.searchHackathons(keyword);
    }

    public Optional<CodeVerseHackathon> getCodeVerseHackathonById(Long hackathonId) {
        return codeVerseHackathonRepository.findById(hackathonId);
    }

    public void deleteCodeVerseHackathon(Long hackathonId) {
        codeVerseHackathonRepository.deleteById(hackathonId);
    }

    public boolean decrementAvailableSlots(Long hackathonId) {
        Optional<CodeVerseHackathon> hackathon = codeVerseHackathonRepository.findById(hackathonId);
        if (hackathon.isPresent() && hackathon.get().getAvailableSlots() > 0) {
            CodeVerseHackathon codeVerseHackathon = hackathon.get();
            codeVerseHackathon.setAvailableSlots(codeVerseHackathon.getAvailableSlots() - 1);
            codeVerseHackathonRepository.save(codeVerseHackathon);
            return true;
        }
        return false;
    }

    public void incrementAvailableSlots(Long hackathonId) {
        Optional<CodeVerseHackathon> hackathon = codeVerseHackathonRepository.findById(hackathonId);
        if (hackathon.isPresent()) {
            CodeVerseHackathon codeVerseHackathon = hackathon.get();
            if (codeVerseHackathon.getAvailableSlots() < codeVerseHackathon.getMaxSlots()) {
                codeVerseHackathon.setAvailableSlots(codeVerseHackathon.getAvailableSlots() + 1);
                codeVerseHackathonRepository.save(codeVerseHackathon);
            }
        }
    }
}
```

## File: CodeVerseRegistrationService.java
```java
package com.codeverse.service;

import com.codeverse.entity.CodeVerseRegistration;
import com.codeverse.entity.CodeVerseRegistration.RegistrationStatus;
import com.codeverse.entity.CodeVerseHackathon;
import com.codeverse.entity.CodeVerseUser;
import com.codeverse.repository.CodeVerseRegistrationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CodeVerseRegistrationService {

    private final CodeVerseRegistrationRepository codeVerseRegistrationRepository;
    private final CodeVerseHackathonService codeVerseHackathonService;
    private final CodeVerseMailService codeVerseMailService;

    public CodeVerseRegistration bookCodeVerseSlot(CodeVerseHackathon hackathon, CodeVerseUser participant, 
                                                     String teamName, Integer teamSize, String specialRequirements) {
        
        // Check if already registered
        if (codeVerseRegistrationRepository.existsByHackathonHackathonIdAndParticipantUserId(
                hackathon.getHackathonId(), participant.getUserId())) {
            throw new RuntimeException("CodeVerse: Already registered for this hackathon");
        }
        
        // Check available slots
        if (hackathon.getAvailableSlots() <= 0) {
            throw new RuntimeException("CodeVerse: No slots available");
        }
        
        // Generate registration code
        String registrationCode = generateCodeVerseRegistrationCode(hackathon.getHackathonId(), participant.getUserId());
        
        CodeVerseRegistration registration = new CodeVerseRegistration();
        registration.setHackathon(hackathon);
        registration.setParticipant(participant);
        registration.setRegistrationCode(registrationCode);
        registration.setTeamName(teamName);
        registration.setTeamSize(teamSize != null ? teamSize : 1);
        registration.setSpecialRequirements(specialRequirements);
        registration.setRegistrationStatus(RegistrationStatus.CONFIRMED);
        
        CodeVerseRegistration savedRegistration = codeVerseRegistrationRepository.save(registration);
        
        // Decrement available slots
        codeVerseHackathonService.decrementAvailableSlots(hackathon.getHackathonId());
        
        // Send booking confirmation email
        codeVerseMailService.sendBookingConfirmationEmail(savedRegistration);
        
        return savedRegistration;
    }

    public List<CodeVerseRegistration> getCodeVerseRegistrationsByParticipant(Long participantId) {
        return codeVerseRegistrationRepository.findByParticipantId(participantId);
    }

    public List<CodeVerseRegistration> getCodeVerseRegistrationsByHackathon(Long hackathonId) {
        return codeVerseRegistrationRepository.findByHackathonId(hackathonId);
    }

    public Optional<CodeVerseRegistration> getCodeVerseRegistrationById(Long registrationId) {
        return codeVerseRegistrationRepository.findById(registrationId);
    }

    public Optional<CodeVerseRegistration> getCodeVerseRegistrationByCode(String registrationCode) {
        return codeVerseRegistrationRepository.findByRegistrationCode(registrationCode);
    }

    public void cancelCodeVerseRegistration(Long registrationId) {
        Optional<CodeVerseRegistration> registration = codeVerseRegistrationRepository.findById(registrationId);
        if (registration.isPresent()) {
            CodeVerseRegistration codeVerseRegistration = registration.get();
            codeVerseRegistration.setRegistrationStatus(RegistrationStatus.CANCELLED);
            codeVerseRegistrationRepository.save(codeVerseRegistration);
            
            // Increment available slots
            codeVerseHackathonService.incrementAvailableSlots(codeVerseRegistration.getHackathon().getHackathonId());
        }
    }

    public Long getConfirmedRegistrationCount(Long hackathonId) {
        return codeVerseRegistrationRepository.countConfirmedRegistrations(hackathonId);
    }

    private String generateCodeVerseRegistrationCode(Long hackathonId, Long participantId) {
        return String.format("CV%04d-%06d-%d", hackathonId, participantId, System.currentTimeMillis());
    }
}
```

## File: CodeVerseMailService.java
```java
package com.codeverse.service;

import com.codeverse.entity.CodeVerseUser;
import com.codeverse.entity.CodeVerseRegistration;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import jakarta.mail.internet.MimeMessage;
import java.time.format.DateTimeFormatter;

@Service
@RequiredArgsConstructor
@Slf4j
public class CodeVerseMailService {

    private final JavaMailSender codeVerseMailSender;

    @Value("${spring.mail.username}")
    private String codeVerseFromEmail;

    public void sendRegistrationSuccessEmail(CodeVerseUser user) {
        try {
            MimeMessage mimeMessage = codeVerseMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom(codeVerseFromEmail);
            helper.setTo(user.getEmail());
            helper.setSubject("🎉 Welcome to CodeVerse Hackathon Marketplace!");

            String htmlContent = String.format("""
                <html>
                <body style='font-family: Arial, sans-serif;'>
                    <div style='background: linear-gradient(135deg, #667eea 0%%, #764ba2 100%%); padding: 30px; text-align: center;'>
                        <h1 style='color: white; margin: 0;'>Welcome to CodeVerse!</h1>
                    </div>
                    <div style='padding: 30px; background-color: #f5f5f5;'>
                        <h2 style='color: #333;'>Hello %s,</h2>
                        <p style='font-size: 16px; color: #666;'>
                            Your CodeVerse account has been successfully created!
                        </p>
                        <div style='background-color: white; padding: 20px; border-radius: 8px; margin: 20px 0;'>
                            <p><strong>Username:</strong> %s</p>
                            <p><strong>Email:</strong> %s</p>
                            <p><strong>Account Type:</strong> %s</p>
                        </div>
                        <p style='font-size: 16px; color: #666;'>
                            You can now explore amazing hackathons and start your coding journey!
                        </p>
                        <div style='text-align: center; margin-top: 30px;'>
                            <a href='http://localhost:8080/codeverse' style='background: #667eea; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block;'>
                                Visit CodeVerse
                            </a>
                        </div>
                    </div>
                    <div style='text-align: center; padding: 20px; color: #999; font-size: 12px;'>
                        <p>© 2026 CodeVerse Hackathon Marketplace. All rights reserved.</p>
                    </div>
                </body>
                </html>
                """, user.getFullName(), user.getUsername(), user.getEmail(), user.getUserType().getUserTypeName());

            helper.setText(htmlContent, true);
            codeVerseMailSender.send(mimeMessage);
            log.info("CodeVerse Registration email sent to: {}", user.getEmail());
        } catch (Exception e) {
            log.error("CodeVerse Failed to send registration email: {}", e.getMessage());
        }
    }

    public void sendPasswordResetOTP(CodeVerseUser user, String otp) {
        try {
            MimeMessage mimeMessage = codeVerseMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom(codeVerseFromEmail);
            helper.setTo(user.getEmail());
            helper.setSubject("🔐 CodeVerse Password Reset OTP");

            String htmlContent = String.format("""
                <html>
                <body style='font-family: Arial, sans-serif;'>
                    <div style='background: #ff6b6b; padding: 30px; text-align: center;'>
                        <h1 style='color: white; margin: 0;'>Password Reset Request</h1>
                    </div>
                    <div style='padding: 30px; background-color: #f5f5f5;'>
                        <h2 style='color: #333;'>Hello %s,</h2>
                        <p style='font-size: 16px; color: #666;'>
                            You requested to reset your CodeVerse account password.
                        </p>
                        <div style='background-color: white; padding: 30px; border-radius: 8px; margin: 20px 0; text-align: center;'>
                            <p style='font-size: 14px; color: #999;'>Your OTP Code:</p>
                            <h1 style='color: #667eea; font-size: 48px; letter-spacing: 10px; margin: 10px 0;'>%s</h1>
                            <p style='font-size: 12px; color: #ff6b6b;'>⏰ Valid for 15 minutes</p>
                        </div>
                        <p style='font-size: 14px; color: #999;'>
                            If you didn't request this, please ignore this email.
                        </p>
                    </div>
                    <div style='text-align: center; padding: 20px; color: #999; font-size: 12px;'>
                        <p>© 2026 CodeVerse Hackathon Marketplace. All rights reserved.</p>
                    </div>
                </body>
                </html>
                """, user.getFullName(), otp);

            helper.setText(htmlContent, true);
            codeVerseMailSender.send(mimeMessage);
            log.info("CodeVerse Password reset OTP sent to: {}", user.getEmail());
        } catch (Exception e) {
            log.error("CodeVerse Failed to send OTP email: {}", e.getMessage());
        }
    }

    public void sendBookingConfirmationEmail(CodeVerseRegistration registration) {
        try {
            MimeMessage mimeMessage = codeVerseMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom(codeVerseFromEmail);
            helper.setTo(registration.getParticipant().getEmail());
            helper.setSubject("🎟️ CodeVerse Hackathon Booking Confirmed!");

            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

            String htmlContent = String.format("""
                <html>
                <body style='font-family: Arial, sans-serif;'>
                    <div style='background: linear-gradient(135deg, #11998e 0%%, #38ef7d 100%%); padding: 30px; text-align: center;'>
                        <h1 style='color: white; margin: 0;'>🎉 Booking Confirmed!</h1>
                    </div>
                    <div style='padding: 30px; background-color: #f5f5f5;'>
                        <h2 style='color: #333;'>Congratulations %s!</h2>
                        <p style='font-size: 16px; color: #666;'>
                            Your slot has been successfully booked for the hackathon.
                        </p>
                        <div style='background-color: white; padding: 25px; border-radius: 8px; margin: 20px 0; border-left: 5px solid #38ef7d;'>
                            <h3 style='color: #667eea; margin-top: 0;'>📋 Booking Details</h3>
                            <p><strong>🎯 Hackathon:</strong> %s</p>
                            <p><strong>📅 Date:</strong> %s</p>
                            <p><strong>🕒 Time:</strong> %s</p>
                            <p><strong>📍 Venue:</strong> %s</p>
                            <p><strong>👥 Team:</strong> %s (%d members)</p>
                            <p><strong>🎫 Registration Code:</strong> <span style='color: #667eea; font-weight: bold;'>%s</span></p>
                        </div>
                        <div style='background-color: #fff3cd; padding: 15px; border-radius: 5px; margin: 20px 0;'>
                            <p style='margin: 0; color: #856404;'>
                                ⚠️ <strong>Important:</strong> Please save your registration code for check-in.
                            </p>
                        </div>
                        <div style='text-align: center; margin-top: 30px;'>
                            <a href='http://localhost:8080/codeverse/participant/bookings' style='background: #11998e; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block;'>
                                View My Bookings
                            </a>
                        </div>
                    </div>
                    <div style='text-align: center; padding: 20px; color: #999; font-size: 12px;'>
                        <p>© 2026 CodeVerse Hackathon Marketplace. All rights reserved.</p>
                    </div>
                </body>
                </html>
                """, 
                registration.getParticipant().getFullName(),
                registration.getHackathon().getHackathonTitle(),
                registration.getHackathon().getEventDate().format(dateFormatter),
                registration.getHackathon().getEventTime().format(timeFormatter),
                registration.getHackathon().getVenueLocation(),
                registration.getTeamName() != null ? registration.getTeamName() : "Individual",
                registration.getTeamSize(),
                registration.getRegistrationCode()
            );

            helper.setText(htmlContent, true);
            codeVerseMailSender.send(mimeMessage);
            log.info("CodeVerse Booking confirmation sent to: {}", registration.getParticipant().getEmail());
        } catch (Exception e) {
            log.error("CodeVerse Failed to send booking confirmation: {}", e.getMessage());
        }
    }
}
```
