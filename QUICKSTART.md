# 🚀 CodeVerse - QUICKSTART GUIDE

## ✅ What You Already Have

The following files are ALREADY CREATED in your root directory:

```
C:\Users\Akbari Nihar\Desktop\codeverse-3\
├── pom.xml ✓
├── codeverse_schema.sql ✓
├── application.properties ✓
├── setup-structure.bat ✓
├── README.md ✓
├── CodeVerseApplication.java ✓
├── CodeVerseUser.java ✓
├── CodeVerseUserType.java ✓
├── CodeVerseCategory.java ✓
├── CodeVerseHackathon.java ✓
├── CodeVerseRegistration.java ✓
├── CodeVerseParticipantController.java ✓
├── ALL_REPOSITORIES.md ✓ (Contains all repository code)
├── ALL_SERVICES.md ✓ (Contains all service code)
├── SECURITY_CONFIG.md ✓ (Contains security config code)
├── ALL_CONTROLLERS_PART1.md ✓ (Contains Auth, Admin, Organizer controllers)
├── ALL_JSP_VIEWS_COMPLETE.md ✓ (Contains ALL JSP files)
├── COMPLETE_SETUP_GUIDE.md ✓
└── ALL_JAVA_FILES_PART1.md ✓
```

---

## 📋 Step-by-Step Installation (10 Minutes)

### STEP 1: Create Directory Structure (1 minute)

Open Command Prompt in `C:\Users\Akbari Nihar\Desktop\codeverse-3`

Run:
```batch
mkdir src\main\java\com\codeverse\entity
mkdir src\main\java\com\codeverse\repository
mkdir src\main\java\com\codeverse\service
mkdir src\main\java\com\codeverse\controller
mkdir src\main\java\com\codeverse\config
mkdir src\main\resources
mkdir src\main\webapp\WEB-INF\views
```

---

### STEP 2: Move Entity Files (1 minute)

Move these files from root to `src\main\java\com\codeverse\entity\`:
```batch
move CodeVerseUserType.java src\main\java\com\codeverse\entity\
move CodeVerseUser.java src\main\java\com\codeverse\entity\
move CodeVerseCategory.java src\main\java\com\codeverse\entity\
move CodeVerseHackathon.java src\main\java\com\codeverse\entity\
move CodeVerseRegistration.java src\main\java\com\codeverse\entity\
```

---

### STEP 3: Move Main Application (1 minute)

Move main class:
```batch
move CodeVerseApplication.java src\main\java\com\codeverse\
```

---

### STEP 4: Move Application Properties (1 minute)

Move config file:
```batch
move application.properties src\main\resources\
```

---

### STEP 5: Create Repository Files (2 minutes)

Open `ALL_REPOSITORIES.md` and copy code for these 5 files into `src\main\java\com\codeverse\repository\`:

1. CodeVerseUserRepository.java
2. CodeVerseUserTypeRepository.java
3. CodeVerseCategoryRepository.java
4. CodeVerseHackathonRepository.java
5. CodeVerseRegistrationRepository.java

---

### STEP 6: Create Service Files (2 minutes)

Open `ALL_SERVICES.md` and copy code for these 5 files into `src\main\java\com\codeverse\service\`:

1. CodeVerseUserService.java
2. CodeVerseCategoryService.java
3. CodeVerseHackathonService.java
4. CodeVerseRegistrationService.java
5. CodeVerseMailService.java

---

### STEP 7: Create Config File (1 minute)

Open `SECURITY_CONFIG.md` and copy code for this file into `src\main\java\com\codeverse\config\`:

1. CodeVerseSecurityConfig.java

---

### STEP 8: Create Controller Files (2 minutes)

Move participant controller:
```batch
move CodeVerseParticipantController.java src\main\java\com\codeverse\controller\
```

Then open `ALL_CONTROLLERS_PART1.md` and copy code for these 3 files into `src\main\java\com\codeverse\controller\`:

1. CodeVerseAuthController.java
2. CodeVerseAdminController.java
3. CodeVerseOrganizerController.java

---

### STEP 9: Create All JSP Views (3 minutes)

Open `ALL_JSP_VIEWS_COMPLETE.md` and copy code for ALL JSP files into `src\main\webapp\WEB-INF\views\`:

1. CodeVerseLayout.jsp
2. CodeVerseLogin.jsp
3. CodeVerseRegister.jsp
4. CodeVerseExplore.jsp
5. CodeVerseDashboard.jsp
6. CodeVerseAdminDashboard.jsp
7. CodeVerseAdminCategories.jsp
8. CodeVerseAdminUsers.jsp
9. CodeVerseOrganizerDashboard.jsp
10. CodeVerseOrganizerHackathons.jsp
11. CodeVerseOrganizerCreate.jsp
12. CodeVerseOrganizerRegistrations.jsp
13. CodeVerseParticipantBookings.jsp
14. CodeVerseHackathonDetails.jsp
15. CodeVerseForgotPassword.jsp
16. CodeVerseResetPassword.jsp

---

### STEP 10: Setup MySQL Database (2 minutes)

1. Open MySQL Command Line or MySQL Workbench
2. Run:
```sql
source C:/Users/Akbari Nihar/Desktop/codeverse-3/codeverse_schema.sql
```

Or copy-paste the entire content of `codeverse_schema.sql` and execute.

---

### STEP 11: Configure Database (1 minute)

Edit `src\main\resources\application.properties`:

Change these lines to match your MySQL setup:
```properties
spring.datasource.username=root
spring.datasource.password=YOUR_MYSQL_PASSWORD
```

For mail service (optional for now):
```properties
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
```

---

### STEP 12: Build & Run (2 minutes)

Open Command Prompt in project root:

```batch
cd "C:\Users\Akbari Nihar\Desktop\codeverse-3"

REM Clean and build
mvn clean install

REM Run the application
mvn spring-boot:run
```

Wait for:
```
╔═══════════════════════════════════════════════╗
║   CodeVerse Hackathon Marketplace Started!   ║
║   Access: http://localhost:8080/codeverse    ║
╚═══════════════════════════════════════════════╝
```

---

## 🎉 Access Your Application

### URL
```
http://localhost:8080/codeverse
```

### Default Credentials

**Admin Account:**
- Username: `admin`
- Password: `Admin@123`

**Organizer Account:**
- Username: `techcorp`
- Password: `Admin@123`

**Participant Account:**
- Username: `john_dev`
- Password: `Admin@123`

---

## 📁 Final Project Structure

```
codeverse-3/
├── pom.xml
├── codeverse_schema.sql
└── src/
    ├── main/
    │   ├── java/com/codeverse/
    │   │   ├── CodeVerseApplication.java ✓
    │   │   ├── entity/
    │   │   │   ├── CodeVerseUser.java ✓
    │   │   │   ├── CodeVerseUserType.java ✓
    │   │   │   ├── CodeVerseCategory.java ✓
    │   │   │   ├── CodeVerseHackathon.java ✓
    │   │   │   └── CodeVerseRegistration.java ✓
    │   │   ├── repository/
    │   │   │   ├── CodeVerseUserRepository.java
    │   │   │   ├── CodeVerseUserTypeRepository.java
    │   │   │   ├── CodeVerseCategoryRepository.java
    │   │   │   ├── CodeVerseHackathonRepository.java
    │   │   │   └── CodeVerseRegistrationRepository.java
    │   │   ├── service/
    │   │   │   ├── CodeVerseUserService.java
    │   │   │   ├── CodeVerseCategoryService.java
    │   │   │   ├── CodeVerseHackathonService.java
    │   │   │   ├── CodeVerseRegistrationService.java
    │   │   │   └── CodeVerseMailService.java
    │   │   ├── controller/
    │   │   │   ├── CodeVerseAuthController.java
    │   │   │   ├── CodeVerseAdminController.java
    │   │   │   ├── CodeVerseOrganizerController.java
    │   │   │   └── CodeVerseParticipantController.java
    │   │   └── config/
    │   │       └── CodeVerseSecurityConfig.java
    │   ├── resources/
    │   │   └── application.properties ✓
    │   └── webapp/WEB-INF/views/
    │       ├── CodeVerseLogin.jsp
    │       ├── CodeVerseRegister.jsp
    │       ├── CodeVerseExplore.jsp
    │       ├── CodeVerseDashboard.jsp
    │       ├── CodeVerseAdminDashboard.jsp
    │       ├── CodeVerseAdminCategories.jsp
    │       ├── CodeVerseAdminUsers.jsp
    │       ├── CodeVerseOrganizerDashboard.jsp
    │       ├── CodeVerseOrganizerHackathons.jsp
    │       ├── CodeVerseOrganizerCreate.jsp
    │       ├── CodeVerseParticipantBookings.jsp
    │       └── CodeVerseHackathonDetails.jsp
    └── test/
```

---

## 🔧 Troubleshooting

### Issue: Maven build fails
**Solution:** Ensure you have JDK 17+ installed
```batch
java -version
```

### Issue: MySQL connection error
**Solution:** Check MySQL is running and credentials are correct in application.properties

### Issue: JSP not found
**Solution:** Ensure all JSP files are in `src/main/webapp/WEB-INF/views/`

### Issue: Port 8080 already in use
**Solution:** Change port in application.properties:
```properties
server.port=8081
```

---

## 🎯 Features Checklist

✅ User Registration & Login (BCrypt encryption)  
✅ Role-Based Access Control (Admin, Organizer, Participant)  
✅ Category Management (Admin)  
✅ User Management (Admin)  
✅ Hackathon Creation (Organizer)  
✅ Hackathon Listing & Search (Participant)  
✅ Slot Booking System  
✅ Registration Management  
✅ Email Notifications (Registration, OTP, Booking)  
✅ Password Reset with OTP  
✅ Modern Bootstrap 5 UI  
✅ Responsive Design  
✅ Database Transactions  
✅ Session Management  

---

## 📚 Key Technologies

- **Spring Boot 3.2.3**
- **Java 17**
- **MySQL 8.0+**
- **Spring Security** (BCrypt)
- **Spring Data JPA** (Hibernate)
- **JSP + JSTL**
- **Bootstrap 5.3**
- **Font Awesome 6.4**
- **JavaMail API**
- **Maven**

---

## 📧 Support

For any issues, check:
1. All files are in correct directories
2. MySQL is running and database is created
3. Application.properties has correct credentials
4. Port 8080 is available
5. JDK 17+ is installed

---

## 🎊 Congratulations!

You now have a fully functional, professional-grade **Hackathon Marketplace Platform**!

### Next Steps:
1. Login as admin and explore
2. Create new categories
3. Login as organizer and create hackathons
4. Login as participant and book slots
5. Customize the design and features as needed

---

**Created by: Lead Java Full-Stack Architect**  
**Project: CodeVerse Hackathon Marketplace v1.0.0**  
**Date: March 2026**

---

## 🚀 Quick Command Reference

```batch
# Navigate to project
cd "C:\Users\Akbari Nihar\Desktop\codeverse-3"

# Build project
mvn clean install

# Run application
mvn spring-boot:run

# Run tests
mvn test

# Package as WAR
mvn package

# Skip tests during build
mvn clean install -DskipTests
```

---

**🎉 Happy Coding with CodeVerse! 🎉**
