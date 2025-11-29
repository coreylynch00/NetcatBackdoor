# Ncat Downloader + Persistent Ncat Bind Shell (POC)

This proof‑of‑concept demonstrates automated deployment of Nmap on a Windows host and the creation of a persistent `ncat` bind‑shell listener using a Windows service.  
It is intended **only for authorized red‑team, lab, and research environments** where post‑exploitation tooling and persistence techniques must be demonstrated safely.

---

## Features

- **Automated Nmap Download & Silent Installation**  
  Retrieves the Netcat installer and installs it without user interaction.

- **Persistent Bind‑Shell Service**  
  Creates a Windows service that automatically launches an `ncat` bind shell at boot for persistence.

- **Immediate Bind Shell**  
  Spawns an active `ncat` bind shell instantly.

---

## Script Overview

1. Creates a temporary directory for the installer.  
2. Downloads the Netcat Windows installer.  
3. Installs Netcat silently using unattended mode.  
4. Constructs a persistence service that launches `ncat` at system startup.  
5. Starts the persistence service immediately to bind shell.

---

## Usage

This script is intended strictly for **authorized research, testing, and red‑team operations**.  
Use it only in controlled environments to demonstrate initial access expansion, payload delivery, and persistence setup.

---
