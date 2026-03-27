@echo off
echo ========================================
echo   CodeVerse - COMPLETE AUTO-SETUP
echo ========================================
echo.
echo This will automatically:
echo   1. Create all Maven directories
echo   2. Move all Java files to correct locations
echo   3. Setup complete project structure
echo.
echo Press any key to continue...
pause >nul
echo.

REM ============================================
REM Step 1: Create ALL directories
REM ============================================
echo [1/2] Creating complete Maven structure...

mkdir "src\main\java\com\codeverse" 2>nul
mkdir "src\main\java\com\codeverse\entity" 2>nul
mkdir "src\main\java\com\codeverse\repository" 2>nul
mkdir "src\main\java\com\codeverse\service" 2>nul
mkdir "src\main\java\com\codeverse\controller" 2>nul
mkdir "src\main\java\com\codeverse\config" 2>nul
mkdir "src\main\resources" 2>nul
mkdir "src\main\webapp\WEB-INF\views" 2>nul
mkdir "src\test\java\com\codeverse" 2>nul

echo    ✓ All directories created!
echo.

REM ============================================
REM Step 2: Move ALL Java files
REM ============================================
echo [2/2] Moving all files to correct locations...

REM Move Main Application
if exist CodeVerseApplication.java move /Y CodeVerseApplication.java "src\main\java\com\codeverse\" >nul 2>&1

REM Move Entity files
if exist CodeVerseUserType.java move /Y CodeVerseUserType.java "src\main\java\com\codeverse\entity\" >nul 2>&1
if exist CodeVerseUser.java move /Y CodeVerseUser.java "src\main\java\com\codeverse\entity\" >nul 2>&1
if exist CodeVerseCategory.java move /Y CodeVerseCategory.java "src\main\java\com\codeverse\entity\" >nul 2>&1
if exist CodeVerseHackathon.java move /Y CodeVerseHackathon.java "src\main\java\com\codeverse\entity\" >nul 2>&1
if exist CodeVerseRegistration.java move /Y CodeVerseRegistration.java "src\main\java\com\codeverse\entity\" >nul 2>&1

REM Move Repository files
if exist CodeVerseUserRepository.java move /Y CodeVerseUserRepository.java "src\main\java\com\codeverse\repository\" >nul 2>&1
if exist CodeVerseUserTypeRepository.java move /Y CodeVerseUserTypeRepository.java "src\main\java\com\codeverse\repository\" >nul 2>&1
if exist CodeVerseCategoryRepository.java move /Y CodeVerseCategoryRepository.java "src\main\java\com\codeverse\repository\" >nul 2>&1
if exist CodeVerseHackathonRepository.java move /Y CodeVerseHackathonRepository.java "src\main\java\com\codeverse\repository\" >nul 2>&1
if exist CodeVerseRegistrationRepository.java move /Y CodeVerseRegistrationRepository.java "src\main\java\com\codeverse\repository\" >nul 2>&1

REM Move Service files
if exist CodeVerseUserService.java move /Y CodeVerseUserService.java "src\main\java\com\codeverse\service\" >nul 2>&1
if exist CodeVerseCategoryService.java move /Y CodeVerseCategoryService.java "src\main\java\com\codeverse\service\" >nul 2>&1
if exist CodeVerseHackathonService.java move /Y CodeVerseHackathonService.java "src\main\java\com\codeverse\service\" >nul 2>&1
if exist CodeVerseRegistrationService.java move /Y CodeVerseRegistrationService.java "src\main\java\com\codeverse\service\" >nul 2>&1
if exist CodeVerseMailService.java move /Y CodeVerseMailService.java "src\main\java\com\codeverse\service\" >nul 2>&1

REM Move Config files
if exist CodeVerseSecurityConfig.java move /Y CodeVerseSecurityConfig.java "src\main\java\com\codeverse\config\" >nul 2>&1

REM Move Controller files
if exist CodeVerseAuthController.java move /Y CodeVerseAuthController.java "src\main\java\com\codeverse\controller\" >nul 2>&1
if exist CodeVerseAdminController.java move /Y CodeVerseAdminController.java "src\main\java\com\codeverse\controller\" >nul 2>&1
if exist CodeVerseOrganizerController.java move /Y CodeVerseOrganizerController.java "src\main\java\com\codeverse\controller\" >nul 2>&1
if exist CodeVerseParticipantController.java move /Y CodeVerseParticipantController.java "src\main\java\com\codeverse\controller\" >nul 2>&1

REM Move Resources
if exist application.properties move /Y application.properties "src\main\resources\" >nul 2>&1

echo    ✓ All files moved!
echo.

REM ============================================
REM Summary
REM ============================================
echo ========================================
echo   ✓ SETUP COMPLETE!
echo ========================================
echo.
echo Maven Structure Created:
echo   ✓ src/main/java/com/codeverse/ (Main app)
echo   ✓ src/main/java/com/codeverse/entity/ (5 entities)
echo   ✓ src/main/java/com/codeverse/repository/ (5 repos)
echo   ✓ src/main/java/com/codeverse/service/ (5 services)
echo   ✓ src/main/java/com/codeverse/controller/ (4 controllers)
echo   ✓ src/main/java/com/codeverse/config/ (1 config)
echo   ✓ src/main/resources/ (application.properties)
echo   ✓ src/main/webapp/WEB-INF/views/ (for JSP files)
echo.
echo ========================================
echo   WHAT'S NEXT? (2 Easy Steps)
echo ========================================
echo.
echo STEP 1: Setup MySQL Database
echo   Open MySQL and run:
echo   source %CD%\codeverse_schema.sql
echo.
echo STEP 2: Update MySQL Password
echo   Edit: src\main\resources\application.properties
echo   Change: spring.datasource.password=YOUR_PASSWORD
echo.
echo THEN RUN:
echo   mvn clean install
echo   mvn spring-boot:run
echo.
echo FINALLY:
echo   Open: http://localhost:8080/codeverse
echo   Login: admin / Admin@123
echo.
echo ========================================
pause
