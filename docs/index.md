# Zero Trust & Identity Lab Guide

**Duration:** 2 Hours | **Skill Level:** Junior Security Analyst

## Architecture Diagram

```mermaid
graph TD
    subgraph "Traditional Perimeter"
        A[Internet] --> B[Firewall]
        B --> C[Flat Network]
        C --> D[All Services Exposed]
    end
    
    subgraph "Zero Trust Architecture"
        E[Internet] --> F{Identity Verify}
        F --> G[Port 8080 Only]
        F --> H[SSH Blocked]
    end
