#!/usr/bin/env bash
# Pretty-print the most recent WAF blocks and honeypot hits.
set -euo pipefail
echo "=== Recent WAF blocks (403) ==="
docker exec edge sh -c 'tail -n 200 /var/log/nginx/sec.json' \
  | awk -F'"status":' '$2 ~ /^403/' | tail -20

echo
echo "=== Recent honeypot hits ==="
docker exec http-honeypot sh -c 'tail -n 100 /var/log/nginx/honey.json' | tail -10

echo
echo "=== Currently banned IPs ==="
docker exec fail2ban fail2ban-client status modsec-anomaly 2>/dev/null \
  | grep "Banned IP list" || true
