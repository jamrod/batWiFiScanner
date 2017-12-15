@echo off
setlocal EnableExtensions
REM Use the following lines to set options
REM path: directory to store results
SET path="C:\Users\Public\Documents\"
REM file: name of file to write results to
SET file=results.txt
REM repeat: Number of times to sample WiFi Connection
SET repeat=10
REM interval: Time between samples
SET interval=5
REM set showavailable to "yes" to see visable WAPS you're not connected to
REM Note- this info does not update very regularly so set your interval to 30 or more
SET showavailable=no

REM begin program
cd\WINDOWS\System32
SET count=0

ECHO Writing to %path%%file%
SET /a testtime=%repeat%*%interval%+4
ECHO test will complete after approx...%testtime% seconds

CALL :GetWiFiConnection >>%path%%file% 2>>&1

:GetWiFiConnection
echo ___%count%____
echo %date% %time%
echo Connected to...
netsh wlan show interfaces | Findstr "SSID Signal"
IF %showavailable%==yes CALL :GetAvailable
SET /a count+=1
timeout %interval%
IF %count% LSS %repeat% GOTO :GetWiFiConnection
echo "test complete..."
GOTO :EOF

:GetAvailable
echo
echo Available Networks...
netsh wlan show networks mode=bssid

:EOF