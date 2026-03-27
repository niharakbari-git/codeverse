-- CodeVerse Hackathon Marketplace Database Schema
-- MySQL 8.0+

DROP DATABASE IF EXISTS codeverse_db;
CREATE DATABASE codeverse_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE codeverse_db;

-- User Types Table
CREATE TABLE codeverse_user_types (
    user_type_id INT PRIMARY KEY AUTO_INCREMENT,
    user_type_name VARCHAR(50) NOT NULL UNIQUE,
    user_type_description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO codeverse_user_types (user_type_name, user_type_description) VALUES
('ADMIN', 'System Administrator with full access'),
('ORGANIZER', 'Hackathon organizers who list events'),
('PARTICIPANT', 'Users who book and participate in hackathons');

-- Users Table
CREATE TABLE codeverse_users (
    user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    phone_number VARCHAR(20),
    user_type_id INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    profile_image VARCHAR(500),
    reset_otp VARCHAR(6),
    otp_expiry TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_type_id) REFERENCES codeverse_user_types(user_type_id),
    INDEX idx_email (email),
    INDEX idx_username (username),
    INDEX idx_user_type (user_type_id)
) ENGINE=InnoDB;

-- Categories Table
CREATE TABLE codeverse_categories (
    category_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    category_description TEXT,
    category_icon VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_active (is_active)
) ENGINE=InnoDB;

INSERT INTO codeverse_categories (category_name, category_description, category_icon) VALUES
('Artificial Intelligence', 'AI and Machine Learning focused hackathons', 'fa-brain'),
('Web Development', 'Full-stack and front-end web development', 'fa-code'),
('Mobile Apps', 'iOS, Android, and cross-platform mobile development', 'fa-mobile-alt'),
('Blockchain', 'Cryptocurrency and distributed ledger technology', 'fa-link'),
('IoT & Hardware', 'Internet of Things and embedded systems', 'fa-microchip'),
('Game Development', 'Video game design and development', 'fa-gamepad');

-- Hackathons Table
CREATE TABLE codeverse_hackathons (
    hackathon_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    hackathon_title VARCHAR(255) NOT NULL,
    hackathon_description TEXT NOT NULL,
    organizer_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    duration_hours INT NOT NULL,
    venue_location VARCHAR(500) NOT NULL,
    venue_type ENUM('ONLINE', 'OFFLINE', 'HYBRID') DEFAULT 'OFFLINE',
    max_slots INT NOT NULL,
    available_slots INT NOT NULL,
    prize_pool DECIMAL(10, 2),
    registration_fee DECIMAL(10, 2) DEFAULT 0.00,
    skills_required TEXT,
    banner_image VARCHAR(500),
    is_active BOOLEAN DEFAULT TRUE,
    status ENUM('DRAFT', 'PUBLISHED', 'ONGOING', 'COMPLETED', 'CANCELLED') DEFAULT 'PUBLISHED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organizer_id) REFERENCES codeverse_users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES codeverse_categories(category_id),
    INDEX idx_organizer (organizer_id),
    INDEX idx_category (category_id),
    INDEX idx_event_date (event_date),
    INDEX idx_status (status),
    CHECK (available_slots <= max_slots),
    CHECK (available_slots >= 0)
) ENGINE=InnoDB;

-- Registrations Table
CREATE TABLE codeverse_registrations (
    registration_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    hackathon_id BIGINT NOT NULL,
    participant_id BIGINT NOT NULL,
    registration_status ENUM('PENDING', 'CONFIRMED', 'CANCELLED', 'WAITLISTED') DEFAULT 'CONFIRMED',
    payment_status ENUM('PENDING', 'PAID', 'REFUNDED') DEFAULT 'PENDING',
    registration_code VARCHAR(50) UNIQUE NOT NULL,
    team_name VARCHAR(200),
    team_size INT DEFAULT 1,
    special_requirements TEXT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (hackathon_id) REFERENCES codeverse_hackathons(hackathon_id) ON DELETE CASCADE,
    FOREIGN KEY (participant_id) REFERENCES codeverse_users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_registration (hackathon_id, participant_id),
    INDEX idx_hackathon (hackathon_id),
    INDEX idx_participant (participant_id),
    INDEX idx_status (registration_status)
) ENGINE=InnoDB;

-- Admin Audit Log
CREATE TABLE codeverse_audit_log (
    log_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    action_type VARCHAR(100) NOT NULL,
    action_description TEXT,
    ip_address VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES codeverse_users(user_id) ON DELETE SET NULL,
    INDEX idx_user (user_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- Insert Default Admin User (password: Admin@123)
INSERT INTO codeverse_users (username, email, password, full_name, phone_number, user_type_id, is_active, is_verified) VALUES
('admin', 'admin@codeverse.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'CodeVerse Administrator', '+1234567890', 1, TRUE, TRUE);

-- Sample Organizers
INSERT INTO codeverse_users (username, email, password, full_name, phone_number, user_type_id, is_active, is_verified) VALUES
('techcorp', 'organizer@techcorp.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'TechCorp Events', '+1234567891', 2, TRUE, TRUE),
('innovate_hub', 'events@innovatehub.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Innovate Hub', '+1234567892', 2, TRUE, TRUE);

-- Sample Participants
INSERT INTO codeverse_users (username, email, password, full_name, phone_number, user_type_id, is_active, is_verified) VALUES
('john_dev', 'john@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'John Developer', '+1234567893', 3, TRUE, TRUE),
('jane_coder', 'jane@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Jane Coder', '+1234567894', 3, TRUE, TRUE);

-- Sample Hackathons
INSERT INTO codeverse_hackathons (hackathon_title, hackathon_description, organizer_id, category_id, event_date, event_time, duration_hours, venue_location, venue_type, max_slots, available_slots, prize_pool, registration_fee, skills_required, status) VALUES
('AI Innovation Challenge 2026', 'Build cutting-edge AI solutions for real-world problems. Compete for amazing prizes and recognition!', 2, 1, '2026-05-15', '09:00:00', 48, 'TechCorp Convention Center, Silicon Valley', 'HYBRID', 100, 100, 50000.00, 25.00, 'Python, TensorFlow, Machine Learning', 'PUBLISHED'),
('Web3 Hackathon', 'Create decentralized applications and blockchain solutions', 3, 4, '2026-06-20', '10:00:00', 36, 'Online via Zoom', 'ONLINE', 200, 200, 30000.00, 0.00, 'Solidity, React, Web3.js', 'PUBLISHED'),
('Mobile App Marathon', 'Design and develop innovative mobile applications', 2, 3, '2026-07-10', '08:00:00', 24, 'Innovate Hub, New York', 'OFFLINE', 50, 50, 20000.00, 50.00, 'React Native, Flutter, Swift', 'PUBLISHED');

-- Views for Analytics
CREATE VIEW codeverse_hackathon_stats AS
SELECT 
    h.hackathon_id,
    h.hackathon_title,
    h.max_slots,
    h.available_slots,
    (h.max_slots - h.available_slots) AS booked_slots,
    COUNT(r.registration_id) AS total_registrations,
    ROUND(((h.max_slots - h.available_slots) / h.max_slots) * 100, 2) AS booking_percentage
FROM codeverse_hackathons h
LEFT JOIN codeverse_registrations r ON h.hackathon_id = r.hackathon_id
WHERE h.is_active = TRUE
GROUP BY h.hackathon_id;

-- Stored Procedure for Booking a Slot
DELIMITER //
CREATE PROCEDURE sp_CodeVerseBookSlot(
    IN p_hackathon_id BIGINT,
    IN p_participant_id BIGINT,
    IN p_team_name VARCHAR(200),
    IN p_team_size INT,
    OUT p_result VARCHAR(100),
    OUT p_registration_code VARCHAR(50)
)
BEGIN
    DECLARE v_available_slots INT;
    DECLARE v_existing_registration INT;
    
    -- Check if already registered
    SELECT COUNT(*) INTO v_existing_registration
    FROM codeverse_registrations
    WHERE hackathon_id = p_hackathon_id AND participant_id = p_participant_id;
    
    IF v_existing_registration > 0 THEN
        SET p_result = 'ALREADY_REGISTERED';
        SET p_registration_code = NULL;
    ELSE
        -- Check available slots
        SELECT available_slots INTO v_available_slots
        FROM codeverse_hackathons
        WHERE hackathon_id = p_hackathon_id AND is_active = TRUE;
        
        IF v_available_slots IS NULL THEN
            SET p_result = 'HACKATHON_NOT_FOUND';
            SET p_registration_code = NULL;
        ELSEIF v_available_slots <= 0 THEN
            SET p_result = 'NO_SLOTS_AVAILABLE';
            SET p_registration_code = NULL;
        ELSE
            -- Generate registration code
            SET p_registration_code = CONCAT('CV', LPAD(p_hackathon_id, 4, '0'), '-', LPAD(p_participant_id, 6, '0'), '-', UNIX_TIMESTAMP());
            
            -- Create registration
            INSERT INTO codeverse_registrations (hackathon_id, participant_id, registration_code, team_name, team_size, registration_status)
            VALUES (p_hackathon_id, p_participant_id, p_registration_code, p_team_name, p_team_size, 'CONFIRMED');
            
            -- Decrease available slots
            UPDATE codeverse_hackathons
            SET available_slots = available_slots - 1
            WHERE hackathon_id = p_hackathon_id;
            
            SET p_result = 'SUCCESS';
        END IF;
    END IF;
END //
DELIMITER ;

COMMIT;
