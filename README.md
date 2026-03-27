# CodeVerse Hackathon Marketplace

## Complete Spring Boot 3.x Hackathon Booking Platform

### Project Overview
CodeVerse is a professional hackathon marketplace platform similar to sports-booking apps where organizers list hackathons as "slots" and participants "book" them.

### Technology Stack
- **Framework**: Spring Boot 3.2.3
- **Java Version**: 17
- **Database**: MySQL 8.0+
- **View Technology**: JSP with JSTL
- **Security**: Spring Security with BCrypt
- **Build Tool**: Maven
- **Frontend**: Bootstrap 5

### Project Structure
```
codeverse-3/
├── pom.xml
├── codeverse_schema.sql
├── setup-structure.bat
├── src/
│   ├── main/
│   │   ├── java/com/codeverse/
│   │   │   ├── CodeVerseApplication.java
│   │   │   ├── entity/
│   │   │   │   ├── CodeVerseUser.java
│   │   │   │   ├── CodeVerseUserType.java
│   │   │   │   ├── CodeVerseCategory.java
│   │   │   │   ├── CodeVerseHackathon.java
│   │   │   │   └── CodeVerseRegistration.java
│   │   │   ├── repository/
│   │   │   │   ├── CodeVerseUserRepository.java
│   │   │   │   ├── CodeVerseUserTypeRepository.java
│   │   │   │   ├── CodeVerseCategoryRepository.java
│   │   │   │   ├── CodeVerseHackathonRepository.java
│   │   │   │   └── CodeVerseRegistrationRepository.java
│   │   │   ├── service/
│   │   │   │   ├── CodeVerseUserService.java
│   │   │   │   ├── CodeVerseCategoryService.java
│   │   │   │   ├── CodeVerseHackathonService.java
│   │   │   │   ├── CodeVerseRegistrationService.java
│   │   │   │   └── CodeVerseMailService.java
│   │   │   ├── controller/
│   │   │   │   ├── CodeVerseAuthController.java
│   │   │   │   ├── CodeVerseAdminController.java
│   │   │   │   ├── CodeVerseOrganizerController.java
│   │   │   │   └── CodeVerseParticipantController.java
│   │   │   ├── config/
│   │   │   │   └── CodeVerseSecurityConfig.java
│   │   │   └── dto/
│   │   │       ├── CodeVerseLoginDTO.java
│   │   │       ├── CodeVerseRegistrationDTO.java
│   │   │       └── CodeVerseBookingDTO.java
│   │   ├── resources/
│   │   │   └── application.properties
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── views/
│   │               ├── CodeVerseLayout.jsp
│   │               ├── CodeVerseLogin.jsp
│   │               ├── CodeVerseRegister.jsp
│   │               ├── CodeVerseExplore.jsp
│   │               ├── CodeVerseDashboard.jsp
│   │               ├── CodeVerseAdminCategories.jsp
│   │               ├── CodeVerseAdminUsers.jsp
│   │               ├── CodeVerseOrganizerHackathons.jsp
│   │               └── CodeVerseOrganizerCreate.jsp
│   └── test/
│       └── java/com/codeverse/
```

### Setup Instructions

#### 1. Prerequisites
- JDK 17 or higher
- Maven 3.6+
- MySQL 8.0+
- IDE (IntelliJ IDEA / Eclipse / VS Code)

#### 2. Database Setup
```bash
# Login to MySQL
mysql -u root -p

# Run the schema script
source codeverse_schema.sql
```

#### 3. Configure Application
Edit `src/main/resources/application.properties`:
- Update database credentials (username/password)
- Configure mail settings for OTP functionality

#### 4. Create Directory Structure
Run the batch file:
```bash
setup-structure.bat
```

Or manually create directories using the commands in the batch file.

#### 5. Build and Run
```bash
# Clean and build
mvn clean install

# Run the application
mvn spring-boot:run
```

#### 6. Access the Application
- URL: http://localhost:8080/codeverse
- Admin Login: admin / Admin@123
- Organizer Login: techcorp / Admin@123
- Participant Login: john_dev / Admin@123

### Features

#### Admin Module
- Manage Categories (AI, Web, Mobile, Blockchain, IoT, Game Dev)
- User Management (View, Activate/Deactivate users)
- System Analytics Dashboard

#### Organizer Module
- Create Hackathons with slots
- Manage own hackathon listings
- View registrations
- Edit/Delete hackathons

#### Participant Module
- Explore marketplace with search and filters
- View hackathon details
- Book slots with team information
- View booking history
- Receive email tickets

### Security Features
- BCrypt password encryption
- Role-based access control (RBAC)
- Session management
- CSRF protection
- Password reset with OTP

### Mail Service
- Registration success tickets
- Password reset OTP
- Booking confirmations

### Database Features
- Foreign key constraints
- Cascading deletes
- Indexes for performance
- Stored procedures for slot booking
- Views for analytics

### API Endpoints

#### Authentication
- POST /auth/login
- POST /auth/register
- POST /auth/logout
- POST /auth/forgot-password
- POST /auth/reset-password

#### Admin
- GET /admin/dashboard
- GET /admin/categories
- POST /admin/categories/create
- PUT /admin/categories/update/{id}
- DELETE /admin/categories/delete/{id}
- GET /admin/users
- PUT /admin/users/toggle-status/{id}

#### Organizer
- GET /organizer/dashboard
- GET /organizer/hackathons
- POST /organizer/hackathons/create
- PUT /organizer/hackathons/update/{id}
- DELETE /organizer/hackathons/delete/{id}
- GET /organizer/registrations/{hackathonId}

#### Participant
- GET /participant/explore
- GET /participant/hackathon/{id}
- POST /participant/book
- GET /participant/bookings
- DELETE /participant/cancel/{registrationId}

### Notes
- All passwords are hashed using BCrypt
- Default admin password: Admin@123
- Session timeout: 30 minutes
- Max file upload size: 10MB
- Slot booking uses database transactions
- Stored procedure ensures atomic slot booking

### Author
Created by Lead Java Full-Stack Architect
CodeVerse Hackathon Marketplace v1.0.0
