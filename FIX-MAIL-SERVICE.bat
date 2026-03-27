@echo off
echo Fixing CodeVerseMailService.java...
copy /Y "src\main\java\com\codeverse\service\CodeVerseMailService_NEW.java" "src\main\java\com\codeverse\service\CodeVerseMailService.java"
del "src\main\java\com\codeverse\service\CodeVerseMailService_NEW.java"
echo Fixed!
pause
