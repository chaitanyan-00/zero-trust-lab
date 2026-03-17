#!/bin/bash
echo "========================================="
echo "ZERO TRUST LAB - VERIFICATION"
echo "========================================="

# Milestone 1: Identity
echo -n "M1: Identity: "
tailscale status | head -1 | awk '{print $2}'

# Milestone 2: Micro-segmentation
echo -n "M2: Port 8080: "
curl -s -o /dev/null -w "%{http_code}\n" http://$(tailscale ip -4):8080/index.html

# Milestone 3: Least Privilege
echo -n "M3: Junior Admin: "
if sudo -u junior-admin sudo -l 2>/dev/null | grep -q restart; then
    echo "RESTRICTED"
else
    echo "OK"
fi

# Milestone 4: Audit Log
echo -n "M4: Audit Log: "
if [ -f ~/security-audit.log ]; then
    ls -la ~/security-audit.log | awk '{print $5 " bytes"}'
else
    echo "Not found"
fi

echo "========================================="
