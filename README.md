# Zero Trust & Identity Lab 🔐

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-brightgreen)](https://chaitanyan-00.github.io/zero-trust-lab)
[![Lab Duration](https://img.shields.io/badge/duration-2%20hours-blue)](https://chaitanyan-00.github.io/zero-trust-lab)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Kali Linux](https://img.shields.io/badge/OS-Kali%20Linux-blueviolet)](https://www.kali.org/)
[![Tailscale](https://img.shields.io/badge/ZTNA-Tailscale-green)](https://tailscale.com)

A hands-on lab designed for **Junior Security Analysts** to demonstrate the transition from **Traditional Perimeter Security** (implicit trust) to a **Zero Trust Architecture (ZTA)** based on **NIST SP 800-207**.

---

## 📋 Table of Contents
- [Introduction](#introduction)
- [Learning Objectives](#learning-objectives)
- [Prerequisites](#prerequisites)
- [Technical Stack](#technical-stack)
- [Lab Milestones](#lab-milestones)
- [Quick Start](#quick-start)
- [Step-by-Step Guide](#step-by-step-guide)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [GenAI Security Co-Pilot](#genai-security-co-pilot)
- [License](#license)

---

## Introduction

Traditional network security operates like a castle with a moat—hard on the outside, soft on the inside. Once an attacker breaches the perimeter, they can move laterally with ease. Zero Trust Architecture flips this model: **never trust, always verify**.

```mermaid
graph TD
    subgraph "Traditional Perimeter Security (Implicit Trust)"
        A[Internet] --> B[Firewall]
        B --> C[Internal Network]
        C --> D[Web Server<br/>Ports: 22,80,443,8080]
        C --> E[Database Server<br/>Ports: 22,3306,5432]
        F[Attacker] -->|Breaches Perimeter| C
        C -.->|Lateral Movement| D
        C -.->|Lateral Movement| E
    end
    
    subgraph "Zero Trust Architecture (NIST SP 800-207)"
        G[Internet] --> H{Identity-Based<br/>Access Control}
        H -->|GitHub SSO| I[Tailscale Mesh Network]
        
        subgraph "Micro-segmented Services"
            J[Web Service<br/>Port 8080 Only]
            K[Database<br/>Port 3306 Only]
            L[SSH Access<br/>Port 22 Only for Admins]
        end
        
        I -->|Identity: SeniorAdmin| J
        I -->|Identity: SeniorAdmin| K
        I -->|Identity: JuniorAdmin| L
        
        M[Attacker] -->|No Valid Identity| H
        M -.->|Blocked by ACL| J
        M -.->|Blocked by ACL| K
    end

    style B fill:#f96,stroke:#333,stroke-width:2px
    style H fill:#9f6,stroke:#333,stroke-width:2px
    style M fill:#f66,stroke:#333,stroke-width:2px
