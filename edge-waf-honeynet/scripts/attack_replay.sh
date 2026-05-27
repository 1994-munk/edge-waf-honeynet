#!/usr/bin/env bash
# Replays a small library of malicious-looking requests so we can confirm
# the WAF and detections light up. Intended for the lab only.
set -euo pipefail
BASE="${1:-http://localhost}"
ua="sqlmap/1.7"

echo "[*] Path traversal..."
curl -s -A "$ua" "$BASE/static/../../../etc/passwd" -o /dev/null -w "%{http_code}\n"

echo "[*] SQLi probe..."
curl -s -A "$ua" "$BASE/search?q=1' UNION SELECT password FROM users--" -o /dev/null -w "%{http_code}\n"

echo "[*] wp-login probe..."
curl -s -A "$ua" -X POST "$BASE/wp-login.php" -d "log=admin&pwd=admin" -o /dev/null -w "%{http_code}\n"

echo "[*] .env probe..."
curl -s -A "$ua" "$BASE/.env" -o /dev/null -w "%{http_code}\n"

echo "[*] xmlrpc probe..."
curl -s -A "$ua" -X POST "$BASE/xmlrpc.php" -d "ping" -o /dev/null -w "%{http_code}\n"
