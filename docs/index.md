# 🧪 Zero Trust & Identity Lab – Step-by-Step Guide

This guide walks you through implementing Zero Trust principles using Tailscale, Linux, and basic security controls.

---

## 🔹 Milestone 1: Identity-Centric Connectivity

### Step 1: Install Tailscale

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

### Step 2: Start Tailscale

```bash
sudo tailscale up
```

👉 Login using GitHub when prompted.

### Step 3: Verify Connection

```bash
tailscale status
```

Expected:
```
100.x.x.x   kali-device   active
```

---

## 🔹 Milestone 2: Micro-Segmentation

### Start Web Server

```bash
mkdir ~/zero-trust-lab
cd ~/zero-trust-lab
echo "Zero Trust Lab Active" > index.html
python3 -m http.server 8080
```

### Test

```bash
curl http://localhost:8080
```

Expected:
```
Zero Trust Lab Active
```

---

## 🔹 Milestone 3: Least Privilege

### Create User

```bash
sudo adduser junior-admin
```

### Restrict Access

```bash
sudo chmod 600 /etc/zero-trust-secrets.conf
```

### Allow Limited Sudo

```bash
sudo visudo
```

Add:
```
junior-admin ALL=(ALL) /usr/local/bin/restart-web-service.sh
```

---

## 🔹 Milestone 4: AI Log Analysis

```bash
sudo journalctl | grep sudo > audit.log
```

Use ChatGPT to analyze logs.

---

## ✅ Summary

- Identity-based access
- Micro-segmentation
- Least privilege
- AI log analysis
