## Zero Trust Architecture – Trust Boundary Diagram

```mermaid
flowchart LR

    %% External Zone
    User[User - GitHub Identity]
    Internet[Public Internet]

    %% Trust Boundary
    subgraph TrustBoundary["Trust Boundary (Tailscale Network)"]
        Device[Kali Linux Device]
        Service[Web Service :8080]
        ACL[Tailscale ACL Policy]
        Sudo[Linux Sudoers RBAC]
        Logs[Audit Logs]
        AI[GenAI Analysis]
    end

    %% Connections
    User -->|SSO Login| Device
    Internet -. Blocked .-> Device

    Device --> ACL
    ACL -->|Allow 8080| Service
    ACL -. Block other ports .-> Service

    Device --> Sudo
    Sudo -->|Restricted access| Service

    Device --> Logs
    Logs --> AI
