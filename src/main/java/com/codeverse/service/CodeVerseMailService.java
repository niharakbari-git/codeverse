package com.codeverse.service;

import com.codeverse.entity.CodeVerseRegistration;
import com.codeverse.entity.CodeVerseUser;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class CodeVerseMailService {

    private final JavaMailSender mailSender;
    private final Environment environment;

    public void sendRegistrationSuccessMail(CodeVerseUser user) {
        try {
            String to = user.getEmail();
            String subject = "Welcome to CodeVerse - Registration Successful!";
            String htmlContent = buildRegistrationSuccessHtml(user);
            sendHtmlEmail(to, subject, htmlContent);
        } catch (Exception e) {
            System.err.println("Error sending registration success email: " + e.getMessage());
        }
    }

    public void sendPasswordResetOTP(CodeVerseUser user, String otp) {
        try {
            String to = user.getEmail();
            String subject = "CodeVerse - Password Reset OTP";
            String htmlContent = buildPasswordResetHtml(user, otp);
            sendHtmlEmail(to, subject, htmlContent);
        } catch (Exception e) {
            System.err.println("Error sending password reset email: " + e.getMessage());
        }
    }

    public void sendBookingConfirmation(CodeVerseRegistration registration) {
        try {
            String to = registration.getParticipant().getEmail();
            String subject = "CodeVerse - Hackathon Registration Confirmation";
            String htmlContent = buildBookingConfirmationHtml(registration);
            sendHtmlEmail(to, subject, htmlContent);
        } catch (Exception e) {
            System.err.println("Error sending booking confirmation email: " + e.getMessage());
        }
    }

    @SuppressWarnings("null")
    private void sendHtmlEmail(String to, String subject, String htmlContent) throws MessagingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
        String from = Objects.requireNonNull(environment.getProperty("spring.mail.username"), "Mail username not configured");
        helper.setFrom(from);
        helper.setTo(to);
        helper.setSubject(subject);
        helper.setText(htmlContent, true);
        mailSender.send(mimeMessage);
    }

    private String buildRegistrationSuccessHtml(CodeVerseUser user) {
        return "<html><body style='font-family: Arial, sans-serif;'>" +
            "<div style='max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px;'>" +
            "<div style='background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 40px 20px; text-align: center;'>" +
            "<h1>Welcome to CodeVerse!</h1>" +
            "</div>" +
            "<div style='padding: 30px 20px;'>" +
            "<h2>Hello " + user.getFullName() + ",</h2>" +
            "<p>Thank you for registering with CodeVerse - your ultimate hackathon marketplace platform!</p>" +
            "<div style='background-color: #f0f4ff; border-left: 4px solid #667eea; padding: 15px; margin: 20px 0;'>" +
            "<strong style='color: #667eea;'>Registration Successful</strong><br/>" +
            "Your account has been created and is ready to use." +
            "</div>" +
            "<p><strong>Account Details:</strong></p>" +
            "<p>Username: <strong>" + user.getUsername() + "</strong><br/>Email: <strong>" + user.getEmail() + "</strong></p>" +
            "</div>" +
            "<div style='background-color: #f9f9f9; padding: 20px; text-align: center; color: #999; font-size: 12px;'>" +
            "<p>Thank you for choosing CodeVerse!</p>" +
            "</div>" +
            "</div></body></html>";
    }

    private String buildPasswordResetHtml(CodeVerseUser user, String otp) {
        return "<html><body style='font-family: Arial, sans-serif;'>" +
            "<div style='max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px;'>" +
            "<div style='background: linear-gradient(135deg, #ec4899 0%, #be185d 100%); color: white; padding: 40px 20px; text-align: center;'>" +
            "<h1>Password Reset Request</h1>" +
            "</div>" +
            "<div style='padding: 30px 20px;'>" +
            "<h2>Hello " + user.getFullName() + ",</h2>" +
            "<p>We received a request to reset your password. Use the OTP below to reset your password:</p>" +
            "<div style='background-color: #fef2f2; border-left: 4px solid #ec4899; padding: 20px; margin: 20px 0; text-align: center;'>" +
            "<div style='font-size: 32px; font-weight: bold; color: #ec4899; letter-spacing: 8px;'>" + otp + "</div>" +
            "<p style='margin-top: 10px; color: #666;'>This OTP is valid for 15 minutes</p>" +
            "</div>" +
            "<p><strong>If you did not request this, please ignore this email.</strong></p>" +
            "</div>" +
            "<div style='background-color: #f9f9f9; padding: 20px; text-align: center; color: #999; font-size: 12px;'>" +
            "<p>CodeVerse Security Team</p>" +
            "</div>" +
            "</div></body></html>";
    }

    private String buildBookingConfirmationHtml(CodeVerseRegistration registration) {
        return "<html><body style='font-family: Arial, sans-serif;'>" +
            "<div style='max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px;'>" +
            "<div style='background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white; padding: 40px 20px; text-align: center;'>" +
            "<h1>Registration Confirmed!</h1>" +
            "</div>" +
            "<div style='padding: 30px 20px;'>" +
            "<h2>Hello " + registration.getParticipant().getFullName() + ",</h2>" +
            "<p>Your registration for the hackathon has been confirmed!</p>" +
            "<div style='background-color: #f0fdf4; border-left: 4px solid #10b981; padding: 15px; margin: 20px 0;'>" +
            "<strong style='color: #10b981;'>Hackathon Details:</strong><br/>" +
            "<p style='margin: 10px 0;'><strong>Event:</strong> " + registration.getHackathon().getHackathonTitle() + "</p>" +
            "<p style='margin: 10px 0;'><strong>Date:</strong> " + registration.getHackathon().getEventDate() + "</p>" +
            "<p style='margin: 10px 0;'><strong>Time:</strong> " + registration.getHackathon().getEventTime() + "</p>" +
            "<p style='margin: 10px 0;'><strong>Location:</strong> " + registration.getHackathon().getVenueLocation() + "</p>" +
            "<p style='margin: 10px 0;'><strong>Registration Code:</strong> <strong style='color: #10b981; font-size: 18px;'>" + registration.getRegistrationCode() + "</strong></p>" +
            "</div>" +
            "<p>Please save this email for your records. Show your registration code at the event check-in.</p>" +
            "</div>" +
            "<div style='background-color: #f9f9f9; padding: 20px; text-align: center; color: #999; font-size: 12px;'>" +
            "<p>See you at the hackathon! - CodeVerse Team</p>" +
            "</div>" +
            "</div></body></html>";
    }
}
