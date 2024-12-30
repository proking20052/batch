@echo off
set NODE_ENV=production

call :check_node
call :check_tsc
call :check_npm
call :clean_dist
call :run

pause

:check_node
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js is not installed. Please install it from https://nodejs.org/
    exit /b 1
)
exit /b 0

:check_tsc
where tsc >nul 2>nul
if %errorlevel% neq 0 (
    echo TypeScript is not installed. Please install it using npm install -g typescript
    exit /b 1
)
exit /b 0

:check_npm
where npm >nul 2>nul
if %errorlevel% neq 0 (
    echo npm is not installed. Please install it from https://nodejs.org/
    exit /b 1
)
exit /b 0

:clean_dist
if exist dist (
    rd /s /q dist
    echo Cleaned dist directory.
)
exit /b 0

:run
tsc src/app.ts --outDir dist
node dist/app.js
exit /b 0

:open_terminal
start cmd /k "cd /workspaces/batch/my-discord-project && discordserver.bat"
exit /b 0
