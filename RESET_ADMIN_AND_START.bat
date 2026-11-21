@echo off
cd /d "%~dp0"
echo Resetting Rahul Mart admin login...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0SETUP_ADMIN.ps1"
if errorlevel 1 (echo Admin reset failed. & pause & exit /b 1)
echo Starting server. Keep this window open.
node server.js
pause
