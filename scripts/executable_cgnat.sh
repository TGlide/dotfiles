#!/bin/bash
# Comprehensive CGNAT and IPv6 connectivity checker for Linux

# ----------- Public IPs -----------
PUBLIC_IPV4=$(curl -4 -s https://ifconfig.me)
PUBLIC_IPV6=$(curl -6 -s https://ifconfig.me)

# ----------- Local Interface Info -----------
WAN_IF=$(ip route show default | awk '/default/ {print $5}')
LOCAL_IPV4=$(ip -4 addr show "$WAN_IF" | awk '/inet / {print $2}' | cut -d/ -f1)
LOCAL_IPV6=$(ip -6 addr show "$WAN_IF" | awk '/inet6 / && !/fe80/ {print $2}' | cut -d/ -f1)

echo "===== CGNAT / IPv6 Check ====="
echo "Network interface: $WAN_IF"
echo

echo "Local IPv4:  $LOCAL_IPV4"
echo "Public IPv4: $PUBLIC_IPV4"
echo
echo "Local IPv6:  $LOCAL_IPV6"
echo "Public IPv6: $PUBLIC_IPV6"
echo
echo "--------------------------------"

# ----------- IPv4 Analysis -----------
if [[ -z "$PUBLIC_IPV4" ]]; then
  echo "🌐 No public IPv4 address detected (possibly IPv6-only connection)."
elif [[ "$LOCAL_IPV4" =~ ^10\. || "$LOCAL_IPV4" =~ ^192\.168\. || "$LOCAL_IPV4" =~ ^172\.(1[6-9]|2[0-9]|3[0-1])\. || "$LOCAL_IPV4" =~ ^100\.(6[4-9]|[7-9][0-9]|1[0-1][0-9]|12[0-7])\. ]]; then
  if [ "$PUBLIC_IPV4" != "$LOCAL_IPV4" ]; then
    echo "⚠️  Your local IPv4 ($LOCAL_IPV4) is private, and your public IPv4 differs."
    echo "➡️  You are likely behind CGNAT or another NAT layer."
  else
    echo "✅ Local and public IPv4 match — you have a public IPv4 address."
  fi
else
  echo "✅ Local IPv4 appears to be public ($LOCAL_IPV4). No CGNAT detected."
fi

echo "--------------------------------"

# ----------- IPv6 Analysis -----------
if [[ -n "$PUBLIC_IPV6" ]]; then
  echo "✅ Public IPv6 is active — your device has global IPv6 connectivity."
else
  echo "❌ No global IPv6 address detected."
fi

echo "--------------------------------"
echo "Done."
