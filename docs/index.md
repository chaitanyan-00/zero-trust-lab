# Zero Trust & Identity Lab - Complete Step-by-Step Guide

## Lab Milestones Overview

  -----------------------------------------------------------------------
  Milestone               Description             Time
  ----------------------- ----------------------- -----------------------
  1\. Identity-Centric    Connect Kali to         30 min
  Connectivity            Tailscale with GitHub   
                          SSO                     

  2\. Micro-segmentation  Restrict access to port 30 min
                          8080 only               

  3\. Least Privilege     Create junior admin     30 min
                          with sudo restrictions  

  4\. GenAI Security      Use AI to audit         30 min
  Co-Pilot                security logs           
  -----------------------------------------------------------------------

------------------------------------------------------------------------

# MILESTONE 1: Identity-Centric Connectivity

Goal: Replace IP-based trust with cryptographic identity using
Tailscale + GitHub SSO

## Step 1.1: Update Kali Linux

``` bash
sudo apt update
sudo apt upgrade -y
sudo apt install -y curl nano git python3
```

Expected output:

    Reading package lists... Done
    Building dependency tree... Done
    Reading state information... Done
    All packages are up to date.

------------------------------------------------------------------------

## Step 1.2: Install Tailscale

``` bash
curl -fsSL https://tailscale.com/install.sh | sh
```

Expected output:

    Installing Tailscale for debian bookworm, using method apt
    ...
    Installation complete! Log in to start using Tailscale by running:
    sudo tailscale up

------------------------------------------------------------------------

## Step 1.3: Start Tailscale and Authenticate

``` bash
sudo systemctl start tailscaled
sudo systemctl enable tailscaled
sudo tailscale up
```

Copy the login URL and authenticate with GitHub.

------------------------------------------------------------------------

## Step 1.4: Enable MagicDNS

Go to:

https://login.tailscale.com/admin/dns

Enable **MagicDNS** and note your tailnet domain.

------------------------------------------------------------------------

## Step 1.5: Verify Identity Connectivity

``` bash
tailscale status
tailscale ip -4
tailscale whois $(tailscale ip -4)
```

This confirms **identity-based networking**.

------------------------------------------------------------------------

# MILESTONE 2: Micro-segmentation

Goal: Restrict access so **only port 8080 is accessible**.

## Step 2.1: Create Web Service

``` bash
mkdir ~/zero-trust-lab
cd ~/zero-trust-lab
```

Create `index.html`.

``` html
<!DOCTYPE html>
<html>
<head>
<title>Zero Trust Lab</title>
</head>
<body>
<h1>✅ Zero Trust Active</h1>
<p>This service is protected by Tailscale ACLs.</p>
</body>
</html>
```

Start server:

``` bash
python3 -m http.server 8080 &
```

------------------------------------------------------------------------

## Step 2.2: Test Locally

``` bash
curl http://localhost:8080/index.html
```

------------------------------------------------------------------------

## Step 2.3: Test via Tailscale

``` bash
curl http://<tailscale-ip>:8080/index.html
```

------------------------------------------------------------------------

## Step 2.4: Apply ACL Policy

Open:

https://login.tailscale.com/admin/acls

Replace policy with:

``` json
{
 "acls": [
  {
   "action": "accept",
   "src": ["*"],
   "dst": ["*:*"],
   "proto": "icmp"
  },
  {
   "action": "accept",
   "src": ["autogroup:member"],
   "dst": ["100.84.212.65:8080"]
  }
 ]
}
```

Everything else becomes **implicitly blocked**.

------------------------------------------------------------------------

# MILESTONE 3: Least Privilege

Goal: Restrict junior admin permissions.

## Step 3.1: Create Sensitive File

``` bash
sudo nano /etc/zero-trust-secrets.conf
```

Example:

    DB_HOST=production-db.internal
    DB_USER=root
    DB_PASS=SuperSecretPassword2026!

Secure file:

``` bash
sudo chmod 600 /etc/zero-trust-secrets.conf
```

------------------------------------------------------------------------

## Step 3.2: Create Junior Admin

``` bash
sudo useradd -m -s /bin/bash junior-admin
sudo passwd junior-admin
```

------------------------------------------------------------------------

## Step 3.3: Restart Script

Create:

``` bash
sudo nano /usr/local/bin/restart-web-service.sh
```

Script:

``` bash
#!/bin/bash
pkill -f "python3 -m http.server 8080"
cd ~/zero-trust-lab
nohup python3 -m http.server 8080 &
```

Make executable:

``` bash
sudo chmod +x /usr/local/bin/restart-web-service.sh
```

------------------------------------------------------------------------

## Step 3.4: Restrict via Sudoers

``` bash
echo "junior-admin ALL=(ALL) /usr/local/bin/restart-web-service.sh" | sudo tee /etc/sudoers.d/zero-trust-junior
sudo chmod 440 /etc/sudoers.d/zero-trust-junior
sudo visudo -c
```

------------------------------------------------------------------------

# MILESTONE 4: GenAI Security Co-Pilot

Goal: Use AI to analyze security logs.

## Step 4.1: Create Security Log

``` bash
nano ~/security-audit.log
```

Example log entries:

    [EVENT 1] Unauthorized File Access
    Result: Permission denied
    Verdict: POLICY VIOLATION

------------------------------------------------------------------------

## Step 4.2: AI Prompt Template

Use this with an AI model:

    You are a Security Co-Pilot analyzing a Zero Trust implementation.

    Tasks:
    1. Classify events
    2. Evaluate control effectiveness
    3. Identify attack patterns
    4. Provide executive summary

------------------------------------------------------------------------

# Verification Script

Create:

``` bash
nano ~/zero-trust-lab/verify.sh
```

Script:

``` bash
#!/bin/bash
echo "Zero Trust Lab Verification"

tailscale status | head -1
curl -s -o /dev/null -w "HTTP %{http_code}
" http://localhost:8080

id junior-admin
ls /etc/sudoers.d/zero-trust-junior
ls /etc/zero-trust-secrets.conf
```

Run:

``` bash
chmod +x verify.sh
./verify.sh
```

------------------------------------------------------------------------

Congratulations 🎉
