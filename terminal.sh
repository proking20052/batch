@echo off
:: Discord Multitool Script

:: Set the Discord token
set /p token=Enter your Discord token: 

:: Set the source server ID
set /p source_server_id=Enter the source Discord server ID: 

:: Set the target server ID
set /p target_server_id=Enter the target Discord server ID: 

:: Fetch channels from the source server
curl -X GET "https://discord.com/api/v9/guilds/%source_server_id%/channels" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -o channels.json

:: Read the channels from the JSON file and create them in the target server
for /F "tokens=*" %%i in (channels.json) do (
    set "line=%%i"
    echo %line% | findstr /r /c:"\"id\": \"[^\"]*\"" >nul && (
        for /F "tokens=2 delims=:" %%a in ("%line%") do (
            set "channel_id=%%a"
            set "channel_id=%channel_id:~1,-1%"
            curl -X POST "https://discord.com/api/v9/guilds/%target_server_id%/channels" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -d "{\"name\":\"%channel_id%\"}"
        )
    )
)

:: Fetch roles from the source server
curl -X GET "https://discord.com/api/v9/guilds/%source_server_id%/roles" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -o roles.json

:: Read the roles from the JSON file and create them in the target server
for /F "tokens=*" %%i in (roles.json) do (
    set "line=%%i"
    echo %line% | findstr /r /c:"\"id\": \"[^\"]*\"" >nul && (
        for /F "tokens=2 delims=:" %%a in ("%line%") do (
            set "role_id=%%a"
            set "role_id=%role_id:~1,-1%"
            curl -X POST "https://discord.com/api/v9/guilds/%target_server_id%/roles" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -d "{\"name\":\"%role_id%\"}"
        )
    )
)

:: Fetch rules from the source server
curl -X GET "https://discord.com/api/v9/guilds/%source_server_id%/rules" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -o rules.json

:: Read the rules from the JSON file and create them in the target server
for /F "tokens=*" %%i in (rules.json) do (
    set "line=%%i"
    echo %line% | findstr /r /c:"\"id\": \"[^\"]*\"" >nul && (
        for /F "tokens=2 delims=:" %%a in ("%line%") do (
            set "rule_id=%%a"
            set "rule_id=%rule_id:~1,-1%"
            curl -X POST "https://discord.com/api/v9/guilds/%target_server_id%/rules" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -d "{\"name\":\"%rule_id%\"}"
        )
    )
)

:: Pause to view the result
pause
