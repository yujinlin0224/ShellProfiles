@echo off
cd /d %~dp0
set Personal=%UserProfile%\Documents
for /f "skip=2 tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Personal') do (set Personal=%%i)
for /f "delims=" %%i in ('echo %Personal%') do (set Personal=%%i)
copy /y "utils\Get-WindowsInfomation.ps1" "%UserProfile%\"
xcopy /e /y "Command Prompt" "%UserProfile%\"
xcopy /e /y "PowerShell" "%Personal%\PowerShell\"
xcopy /e /y "Windows Terminal" "%LocalAppData%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
