## 🔐 Zero Trust Architecture – Trust Boundary Diagram

```mermaid
flowchart LR

    %% External Zone
    User[👤 User (GitHub Identity)]
    Internet[🌐 Public Internet]

    %% Trust Boundary
    subgraph TrustBoundary["🔐 Trust Boundary (Tailscale Network)"]
    
        Device[💻 Kali Linux Device]
        Service[🌐 Web Service :8080]
        ACL[Tailscale ACL Policy]
        Sudo[Linux Sudoers RBAC]
        Logs[📜 Audit Logs]
        AI[🤖 GenAI Security Analysis]

    end

    %% Connections
    User -->|SSO Login| Device
    Internet -. BLOCKED .-> Device

    Device --> ACL
    ACL -->|Allow :8080| Service
    ACL -. Block All Other Ports .-> Service

    Device --> Sudo
    Sudo -->|Limited Access| Service

    Device --> Logs
    Logs --> AI



---

# 🧠 HOW THIS SCORES MARKS

This diagram clearly shows:

### ✅ Trust Boundary
- Everything inside **Tailscale network = trusted zone**
- Everything outside = untrusted

---

### ✅ Identity-Based Access
- User → GitHub SSO → Device

---

### ✅ Micro-Segmentation
- ACL allows only **port 8080**
- Blocks all other ports

---

### ✅ Least Privilege
- `sudoers` restricts actions

---

### ✅ Monitoring + AI
- Logs → analyzed by AI

---

# 🔥 PRO TIP (for extra marks)

Add this below diagram:

```markdown
### 💡 Key Insight

This architecture enforces Zero Trust by:

- Eliminating implicit trust based on network location
- Enforcing identity-based authentication
- Applying strict access controls (ACLs + RBAC)
- Continuously monitoring activity with AI-assisted analysis
