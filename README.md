# 🔐 Zero Trust & Identity Lab

> A hands-on lab demonstrating the transition from Traditional Perimeter Security to Zero Trust Architecture (ZTA) based on NIST SP 800-207.

---

## 📌 Overview

This project simulates a real-world Zero Trust environment using open-source tools.

Instead of trusting devices based on network location (IP-based trust), this lab enforces:

- Identity-based authentication
- Micro-segmented access control
- Least privilege at OS level
- Continuous monitoring using logs + AI

---

## 🎯 Learning Objectives

By completing this lab, you will:

- Understand **Identity-Centric Connectivity**
- Implement **Zero Trust Networking using Tailscale**
- Enforce **Micro-segmentation using ACL policies**
- Apply the **Principle of Least Privilege (RBAC)**
- Use **Generative AI for security log analysis**

---

## 🛠️ Tech Stack

| Component        | Technology            | Purpose |
|----------------|----------------------|--------|
| OS             | Kali Linux           | Lab environment |
| Network        | Tailscale            | Zero Trust Networking |
| Identity       | GitHub SSO           | Authentication |
| Access Control | Tailscale ACLs       | Micro-segmentation |
| OS Security    | sudoers              | Least privilege |
| Service        | Python HTTP Server   | Test application |
| AI             | ChatGPT / Claude     | Security analysis |

---

## ⚙️ Prerequisites

- Kali Linux (or Ubuntu/Debian)
- GitHub account
- Basic Linux command knowledge
- Internet connection

---

## 🚀 Lab Guide (Step-by-Step)

👉 **Live Lab Guide:**  
https://chaitanyan-00.github.io/zero-trust-lab

---

## 🔐 Architecture Diagram (Trust Boundary)

```mermaid
flowchart LR

User[User Identity (GitHub SSO)]
ZTNA[Tailscale Network]
Server[Kali Linux Node]
Service[Web Service :8080]
Secrets[Sensitive File (/etc/zero-trust-secrets.conf)]

User -->|Authenticated| ZTNA
ZTNA --> Server
Server --> Service
Server --> Secrets

Service -->|Allowed Access| User
Secrets -->|Blocked Access| User
