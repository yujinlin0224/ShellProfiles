@echo off
cd /d %~dp0
set personal=%USERPROFILE%\Documents
for /f "skip=2 tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Personal') do (set personal=%%i)
for /f "delims=" %%i in ('echo %personal%') do (set personal=%%i)
copy /y "utils\Get-WindowsInfomation.ps1" "%USERPROFILE%\"
xcopy /e /y "Command Prompt" "%USERPROFILE%\"
xcopy /e /y "PowerShell" "%personal%\PowerShell\"
xcopy /e /y "Windows Terminal" "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
