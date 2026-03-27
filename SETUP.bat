@echo off
cd /d "%~dp0"
echo.
echo Creating Maven directories...
mkdir "src\main\java\com\codeverse" 2>nul
mkdir "src\main\java\com\codeverse\entity" 2>nul
mkdir "src\main\java\com\codeverse\repository" 2>nul
mkdir "src\main\java\com\codeverse\service" 2>nul
mkdir "src\main\java\com\codeverse\controller" 2>nul
mkdir "src\main\java\com\codeverse\config" 2>nul
mkdir "src\main\resources" 2>nul
mkdir "src\main\webapp\WEB-INF\views" 2>nul
echo Done!
echo.
echo Moving Java files...
if exist "CodeVerseApplication.java" move /Y "CodeVerseApplication.java" "src\main\java\com\codeverse\" >nul
if exist "CodeVerseUserType.java" move /Y "CodeVerseUserType.java" "src\main\java\com\codeverse\entity\" >nul
if exist "CodeVerseUser.java" move /Y "CodeVerseUser.java" "src\main\java\com\codeverse\entity\" >nul
if exist "CodeVerseCategory.java" move /Y "CodeVerseCategory.java" "src\main\java\com\codeverse\entity\" >nul
if exist "CodeVerseHackathon.java" move /Y "CodeVerseHackathon.java" "src\main\java\com\codeverse\entity\" >nul
if exist "CodeVerseRegistration.java" move /Y "CodeVerseRegistration.java" "src\main\java\com\codeverse\entity\" >nul
if exist "CodeVerseUserRepository.java" move /Y "CodeVerseUserRepository.java" "src\main\java\com\codeverse\repository\" >nul
if exist "CodeVerseUserTypeRepository.java" move /Y "CodeVerseUserTypeRepository.java" "src\main\java\com\codeverse\repository\" >nul
if exist "CodeVerseCategoryRepository.java" move /Y "CodeVerseCategoryRepository.java" "src\main\java\com\codeverse\repository\" >nul
if exist "CodeVerseHackathonRepository.java" move /Y "CodeVerseHackathonRepository.java" "src\main\java\com\codeverse\repository\" >nul
if exist "CodeVerseRegistrationRepository.java" move /Y "CodeVerseRegistrationRepository.java" "src\main\java\com\codeverse\repository\" >nul
if exist "CodeVerseUserService.java" move /Y "CodeVerseUserService.java" "src\main\java\com\codeverse\service\" >nul
if exist "CodeVerseCategoryService.java" move /Y "CodeVerseCategoryService.java" "src\main\java\com\codeverse\service\" >nul
if exist "CodeVerseHackathonService.java" move /Y "CodeVerseHackathonService.java" "src\main\java\com\codeverse\service\" >nul
if exist "CodeVerseRegistrationService.java" move /Y "CodeVerseRegistrationService.java" "src\main\java\com\codeverse\service\" >nul
if exist "CodeVerseMailService.java" move /Y "CodeVerseMailService.java" "src\main\java\com\codeverse\service\" >nul
if exist "CodeVerseSecurityConfig.java" move /Y "CodeVerseSecurityConfig.java" "src\main\java\com\codeverse\config\" >nul
if exist "CodeVerseAuthController.java" move /Y "CodeVerseAuthController.java" "src\main\java\com\codeverse\controller\" >nul
if exist "CodeVerseAdminController.java" move /Y "CodeVerseAdminController.java" "src\main\java\com\codeverse\controller\" >nul
if exist "CodeVerseOrganizerController.java" move /Y "CodeVerseOrganizerController.java" "src\main\java\com\codeverse\controller\" >nul
if exist "CodeVerseParticipantController.java" move /Y "CodeVerseParticipantController.java" "src\main\java\com\codeverse\controller\" >nul
if exist "application.properties" move /Y "application.properties" "src\main\resources\" >nul
echo Done!
echo.
echo ========================================
echo SUCCESS! Project structure is ready!
echo ========================================
echo.
echo Next steps:
echo 1. Setup MySQL: Run codeverse_schema.sql in MySQL
echo 2. Update password in: src\main\resources\application.properties
echo 3. Build: mvn clean install
echo 4. Run: mvn spring-boot:run
echo.
pause
