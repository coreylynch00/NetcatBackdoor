# Automated Nmap Installer & Dynamic Ncat Listener (POC)

This PowerShell proof‑of‑concept automates the deployment of Nmap on a Windows host and sets up an `ncat` listener using the first available port, starting from port **87**. It is intended for controlled red‑team, lab, and research scenarios where demonstrating post‑exploitation tooling setup is required.

## Features

- **Automatic Nmap Download & Silent Installation**  
  Retrieves the latest Nmap installer and installs it quietly without user interaction.

- **Dynamic Port Selection**  
  Scans for the first open TCP port, starting at 87, and avoids conflicts with ports already in use.

- **Automated Ncat Listener**  
  Launches `ncat` bound to the selected port and spawns an interactive `cmd.exe` session for demonstration purposes.

## Script Overview

The script performs the following operations:

1. Downloads the latest Nmap installer.
2. Installs Nmap silently.
3. Navigates to the Nmap program directory.
4. Identifies an available TCP port using a simple listener test.
5. Starts `ncat` in listener mode with `cmd.exe` attached to bind a reverse shell.

## Usage

This script is intended for **research and authorized red‑team operations only**.  
Run it in a controlled environment to demonstrate payload delivery and post-exploitation tooling setup.
