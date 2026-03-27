@echo off
echo Creating CodeVerse Project Structure...

mkdir "src\main\java\com\codeverse\entity" 2>nul
mkdir "src\main\java\com\codeverse\repository" 2>nul
mkdir "src\main\java\com\codeverse\service" 2>nul
mkdir "src\main\java\com\codeverse\controller" 2>nul
mkdir "src\main\java\com\codeverse\config" 2>nul
mkdir "src\main\java\com\codeverse\dto" 2>nul
mkdir "src\main\resources" 2>nul
mkdir "src\main\webapp\WEB-INF\views" 2>nul
mkdir "src\test\java\com\codeverse" 2>nul

echo Directories created successfully!
echo Project structure is ready.
pause
