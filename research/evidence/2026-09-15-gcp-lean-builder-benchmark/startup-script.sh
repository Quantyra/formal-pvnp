#!/usr/bin/env bash
set -euo pipefail

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y git curl build-essential zstd jq time ca-certificates

cat >/usr/local/sbin/quantyra-idle-shutdown <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
state=/var/lib/quantyra-idle-shutdown
now=$(date +%s)
mkdir -p "$state"

# Builds, package installation, and interactive SSH sessions all count as activity.
if pgrep -x lean >/dev/null || pgrep -x lake >/dev/null || pgrep -x git >/dev/null || \
   pgrep -x apt >/dev/null || pgrep -x apt-get >/dev/null || pgrep -x dpkg >/dev/null || \
   pgrep -x curl >/dev/null || pgrep -x tar >/dev/null || pgrep -x zstd >/dev/null || \
   who | grep -q .; then
  printf '%s\n' "$now" >"$state/last-active"
  exit 0
fi

if [[ ! -f "$state/last-active" ]]; then
  printf '%s\n' "$now" >"$state/last-active"
  exit 0
fi
last=$(cat "$state/last-active")
if (( now - last >= 2700 )); then
  logger -t quantyra-idle-shutdown '45 minutes idle; powering off'
  /sbin/shutdown -h now
fi
EOF
chmod 0755 /usr/local/sbin/quantyra-idle-shutdown

cat >/etc/systemd/system/quantyra-idle-shutdown.service <<'EOF'
[Unit]
Description=Quantyra Lean builder idle shutdown check

[Service]
Type=oneshot
ExecStart=/usr/local/sbin/quantyra-idle-shutdown
EOF

cat >/etc/systemd/system/quantyra-idle-shutdown.timer <<'EOF'
[Unit]
Description=Check Quantyra Lean builder idleness every five minutes

[Timer]
OnBootSec=5min
OnUnitActiveSec=5min
AccuracySec=30s
Persistent=true

[Install]
WantedBy=timers.target
EOF

mkdir -p /var/lib/quantyra-idle-shutdown
date +%s >/var/lib/quantyra-idle-shutdown/last-active
systemctl daemon-reload
systemctl enable --now quantyra-idle-shutdown.timer

touch /var/lib/quantyra-builder-ready
