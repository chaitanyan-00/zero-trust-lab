#!/bin/bash
echo "========================================="
echo "ZERO TRUST LAB - VERIFICATION"
echo "========================================="
echo ""

# Milestone 1: Identity
echo -n "✅ M1: Identity: "
tailscale status | head -1 | awk '{print $2}'

# Milestone 2: Micro-segmentation
echo -n "✅ M2: Port 8080: "
curl -s -o /dev/null -w "HTTP %{http_code}\n" http://$(tailscale ip -4):8080/index.html

# Milestone 3: Least Privilege (Fixed!)
echo "✅ M3: Least Privilege Tests:"

# Test 1: Check if junior-admin user exists
echo -n "   - Junior admin user: "
if id junior-admin &>/dev/null; then
    echo "EXISTS"
else
    echo "MISSING"
fi

# Test 2: Check sudoers file
echo -n "   - Sudoers configuration: "
if [ -f /etc/sudoers.d/zero-trust-junior ]; then
    echo "EXISTS"
    echo "     $(sudo cat /etc/sudoers.d/zero-trust-junior)"
else
    echo "MISSING"
fi

# Test 3: Check sensitive file permissions
echo -n "   - Sensitive file permissions: "
if [ -f /etc/zero-trust-secrets.conf ]; then
    PERMS=$(stat -c "%a" /etc/zero-trust-secrets.conf 2>/dev/null)
    if [ "$PERMS" = "600" ]; then
        echo "OK (600)"
    else
        echo "WARNING (${PERMS})"
    fi
else
    echo "MISSING"
fi

# Milestone 4: Audit Log
echo -n "✅ M4: Audit Log: "
if [ -f ~/security-audit.log ]; then
    SIZE=$(ls -la ~/security-audit.log | awk '{print $5}')
    echo "${SIZE} bytes"
    echo "   - Preview (first 5 lines):"
    head -5 ~/security-audit.log | sed 's/^/     /'
else
    echo "Not found"
fi

echo ""
echo "========================================="
echo "MANUAL TESTS REQUIRED (Run these):"
echo "========================================="
echo ""
echo "1. Test junior-admin restrictions:"
echo "   sudo -u junior-admin cat /etc/zero-trust-secrets.conf"
echo "   # Should show: Permission denied"
echo ""
echo "2. Test junior-admin service restart:"
echo "   sudo -u junior-admin sudo /usr/local/bin/restart-web-service.sh"
echo "   # Enter junior-admin password (junior123) when prompted"
echo ""
echo "3. Test admin access:"
echo "   sudo cat /etc/zero-trust-secrets.conf | head -3"
echo "   # Should show the credentials"
echo ""
echo "========================================="
