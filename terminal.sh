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

:: Pause to view the result
pause
:: Fetch members from the source server
curl -X GET "https://discord.com/api/v9/guilds/%source_server_id%/members?limit=1000" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -o members.json

:: Read the members from the JSON file and add them to the target server
for /F "tokens=*" %%i in (members.json) do (
    set "line=%%i"
    echo %line% | findstr /r /c:"\"user\": {\"id\": \"[^\"]*\"" >nul && (
        for /F "tokens=2 delims=:" %%a in ("%line%") do (
            set "member_id=%%a"
            set "member_id=%member_id:~1,-1%"
            curl -X PUT "https://discord.com/api/v9/guilds/%target_server_id%/members/%member_id%" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -d "{}"
        )
    )
)

:: Fetch emojis from the source server
curl -X GET "https://discord.com/api/v9/guilds/%source_server_id%/emojis" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -o emojis.json

:: Read the emojis from the JSON file and create them in the target server
for /F "tokens=*" %%i in (emojis.json) do (
    set "line=%%i"
    echo %line% | findstr /r /c:"\"id\": \"[^\"]*\"" >nul && (
        for /F "tokens=2 delims=:" %%a in ("%line%") do (
            set "emoji_id=%%a"
            set "emoji_id=%emoji_id:~1,-1%"
            curl -X POST "https://discord.com/api/v9/guilds/%target_server_id%/emojis" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -d "{\"name\":\"%emoji_id%\"}"
        )
    )
)

:: Fetch bots from the source server
curl -X GET "https://discord.com/api/v9/guilds/%source_server_id%/members?limit=1000" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -o bots.json

:: Read the bots from the JSON file and add them to the target server
for /F "tokens=*" %%i in (bots.json) do (
    set "line=%%i"
    echo %line% | findstr /r /c:"\"bot\": true" >nul && (
        for /F "tokens=2 delims=:" %%a in ("%line%") do (
            set "bot_id=%%a"
            set "bot_id=%bot_id:~1,-1%"
            curl -X PUT "https://discord.com/api/v9/guilds/%target_server_id%/members/%bot_id%" -H "Authorization: Bot %token%" -H "Content-Type: application/json" -d "{}"
        )
    )
)
