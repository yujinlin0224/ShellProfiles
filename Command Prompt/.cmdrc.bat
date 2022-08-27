@echo off

setlocal
for /F "delims=" %%i in ('hostname') do (set hostname=%%i)
setx PROMPT "%USERNAME%@%hostname%:$m$p$_$g$s"
endlocal

chcp 65001
title Command Prompt
cls

setlocal
for /F "tokens=1,2 delims=#" %%i in ('"prompt #$H#$E# & echo on & for %%j in (1) do rem"') do (set ESC=%%j)
for /F "tokens=*" %%i in ('pwsh -NoProfile -NoLogo "%USERPROFILE%\Get-WindowsInfomation.ps1"') do (set wininfo=%%i)
if exist "%PROGRAMFILES(X86)%\clink\" (
  for /F "tokens=*" %%i in ('"%PROGRAMFILES(X86)%\clink\clink_x64.exe" --version') do (set cmdinfo=Clink %%i)
) else (
  set cmdinfo=Command Prompt
)
echo %ESC%[96m%cmdinfo% [%wininfo%]%ESC%[0m
echo Copyright © Microsoft Corporation. All rights reserved.
endlocal

if exist "%USERPROFILE%\miniconda3\" (
  call "%USERPROFILE%\miniconda3\Scripts\activate.bat" base
)
if exist "%PROGRAMFILES(X86)%\clink\" (
  "%PROGRAMFILES(X86)%\clink\clink.bat" inject --quiet
)
