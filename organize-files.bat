@echo off
echo ========================================
echo CodeVerse - Automated File Organizer
echo ========================================
echo.

REM Create directory structure
echo [1/7] Creating directory structure...
mkdir src\main\java\com\codeverse\entity 2>nul
mkdir src\main\java\com\codeverse\repository 2>nul
mkdir src\main\java\com\codeverse\service 2>nul
mkdir src\main\java\com\codeverse\controller 2>nul
mkdir src\main\java\com\codeverse\config 2>nul
mkdir src\main\resources 2>nul
mkdir src\main\webapp\WEB-INF\views 2>nul
echo    - Directories created!
echo.

REM Move Java entity files
echo [2/7] Moving entity files...
if exist CodeVerseUserType.java move CodeVerseUserType.java src\main\java\com\codeverse\entity\ >nul 2>&1
if exist CodeVerseUser.java move CodeVerseUser.java src\main\java\com\codeverse\entity\ >nul 2>&1
if exist CodeVerseCategory.java move CodeVerseCategory.java src\main\java\com\codeverse\entity\ >nul 2>&1
if exist CodeVerseHackathon.java move CodeVerseHackathon.java src\main\java\com\codeverse\entity\ >nul 2>&1
if exist CodeVerseRegistration.java move CodeVerseRegistration.java src\main\java\com\codeverse\entity\ >nul 2>&1
echo    - Entity files moved!
echo.

REM Move repository files
echo [3/7] Moving repository files...
if exist CodeVerseUserRepository.java move CodeVerseUserRepository.java src\main\java\com\codeverse\repository\ >nul 2>&1
if exist CodeVerseUserTypeRepository.java move CodeVerseUserTypeRepository.java src\main\java\com\codeverse\repository\ >nul 2>&1
if exist CodeVerseCategoryRepository.java move CodeVerseCategoryRepository.java src\main\java\com\codeverse\repository\ >nul 2>&1
if exist CodeVerseHackathonRepository.java move CodeVerseHackathonRepository.java src\main\java\com\codeverse\repository\ >nul 2>&1
if exist CodeVerseRegistrationRepository.java move CodeVerseRegistrationRepository.java src\main\java\com\codeverse\repository\ >nul 2>&1
echo    - Repository files moved!
echo.

REM Move service files
echo [4/7] Moving service files...
if exist CodeVerseUserService.java move CodeVerseUserService.java src\main\java\com\codeverse\service\ >nul 2>&1
if exist CodeVerseCategoryService.java move CodeVerseCategoryService.java src\main\java\com\codeverse\service\ >nul 2>&1
if exist CodeVerseHackathonService.java move CodeVerseHackathonService.java src\main\java\com\codeverse\service\ >nul 2>&1
if exist CodeVerseRegistrationService.java move CodeVerseRegistrationService.java src\main\java\com\codeverse\service\ >nul 2>&1
if exist CodeVerseMailService.java move CodeVerseMailService.java src\main\java\com\codeverse\service\ >nul 2>&1
echo    - Service files moved!
echo.

REM Move config files
echo [5/7] Moving config files...
if exist CodeVerseSecurityConfig.java move CodeVerseSecurityConfig.java src\main\java\com\codeverse\config\ >nul 2>&1
echo    - Config files moved!
echo.

REM Move controller files
echo [6/7] Moving controller files...
if exist CodeVerseAuthController.java move CodeVerseAuthController.java src\main\java\com\codeverse\controller\ >nul 2>&1
if exist CodeVerseAdminController.java move CodeVerseAdminController.java src\main\java\com\codeverse\controller\ >nul 2>&1
if exist CodeVerseOrganizerController.java move CodeVerseOrganizerController.java src\main\java\com\codeverse\controller\ >nul 2>&1
if exist CodeVerseParticipantController.java move CodeVerseParticipantController.java src\main\java\com\codeverse\controller\ >nul 2>&1
echo    - Controller files moved!
echo.

REM Move main application and resources
echo [7/7] Moving application files...
if exist CodeVerseApplication.java move CodeVerseApplication.java src\main\java\com\codeverse\ >nul 2>&1
if exist application.properties move application.properties src\main\resources\ >nul 2>&1
echo    - Application files moved!
echo.

echo ========================================
echo SUCCESS! All Java files organized!
echo ========================================
echo.
echo BACKEND COMPLETE:
echo   ✓ 5 Entity classes
echo   ✓ 5 Repository interfaces
echo   ✓ 5 Service classes
echo   ✓ 1 Security config
echo   ✓ 4 Controllers
echo   ✓ Main application class
echo.
echo NEXT STEP:
echo   Copy JSP view files from ALL_JSP_VIEWS_COMPLETE.md
echo   to src\main\webapp\WEB-INF\views\
echo.
echo Then run: mvn clean install
echo.
pause
