@echo off
title Discord Multitool
:menu
cls
echo ================================
echo        Discord Multitool
echo ================================
echo 1. Start Discord
echo 2. Kill Discord Process
echo 3. Check Discord Status
echo 4. Exit
echo ================================
set /p choice=Choose an option: 

if %choice%==1 goto start_discord
if %choice%==2 goto kill_discord
if %choice%==3 goto check_status
if %choice%==4 goto exit

:start_discord
echo Starting Discord...
start "" "C:\Users\%USERNAME%\AppData\Local\Discord\Update.exe" --processStart Discord.exe
pause
goto menu

:kill_discord
echo Killing Discord process...
taskkill /IM Discord.exe /F
pause
goto menu

:check_status
echo Checking Discord status...
tasklist /FI "IMAGENAME eq Discord.exe"
pause
goto menu

:exit
exit
:bot_server
echo Starting Discord bot server...
start "" "C:\Path\To\Your\Bot\bot.exe"
pause
goto menu
:join_server
echo Joining Discord server...
start "" "C:\Path\To\Your\Joiner\joiner.exe"
pause
goto menu
