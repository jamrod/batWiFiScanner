REM Not Complete
echo off
setlocal EnableExtensions
REM begin program
cd\WINDOWS\System32
REM Gather variables from user
SET /p path=Enter path to write log file to:
SET /p file=Enter name for log file:
SET /p showavailable=Show all visible SSID's? Enter y or n:
SET count=0

:WALKTEST
SET /p tag=Enter tag for scan %count%:
ECHO Writing to %path%%file%
CALL:GETWIFICONNECTION >>%path%%file% 2>>&1
SET /p scanagain=Scan again?:
IF %scanagain%==y (GOTO :WALKTEST) ELSE GOTO END

:GetWiFiConnection
echo ___%count%____
echo %date% %time%
echo %tag%
echo Connected to...
netsh wlan show interfaces | Findstr "SSID Signal"
IF %showavailable%==yes CALL :GetAvailable
echo _
SET /a count+=1
GOTO :EOF

:GetAvailable
echo
echo Available Networks...
netsh wlan show networks mode=bssid
GOTO :EOF

:END
ECHO "TEST COMPLETE"