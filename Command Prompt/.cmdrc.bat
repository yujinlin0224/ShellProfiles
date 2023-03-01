@echo off

setlocal
for /F "delims=" %%i in ('HOSTNAME') do (set HostName=%%i)
setx PROMPT "%UserName%@%HostName%:$m$p$_$g$s"
endlocal

chcp 65001
title Command Prompt
cls

setlocal
for /F "tokens=1,2 delims=#" %%i in ('"prompt #$H#$E# & echo on & for %%j in (1) do rem"') do (set ESC=%%j)
for /F "tokens=*" %%i in ('pwsh -NoProfile -NoLogo "%UserProfile%\Get-WindowsInfomation.ps1"') do (set WinInfo=%%i)
if exist "%ProgramFiles(x86)%\clink\" (
  for /F "tokens=*" %%i in ('"%ProgramFiles(x86)%\clink\clink_x64.exe" --version') do (set cmdinfo=Clink %%i)
) else (
  set CmdInfo=Command Prompt
)
echo %ESC%[92m%CmdInfo% [%WinInfo%]%ESC%[0m
echo %ESC%[90mCopyright © Microsoft Corporation. All rights reserved.%ESC%[0m
endlocal

if exist "%UserProfile%\miniconda3\" (
  call "%UserProfile%\miniconda3\Scripts\activate.bat" base
)
if exist "%ProgramFiles(x86)%\clink\" (
  "%ProgramFiles(x86)%\clink\clink.bat" inject --quiet
)
