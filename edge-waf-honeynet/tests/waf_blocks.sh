#!/usr/bin/env bash
# Sanity test: the WAF must block the obvious stuff with 4xx.
set -euo pipefail
BASE="${BASE:-http://localhost}"
expect_block() {
  local code; code=$(curl -s -o /dev/null -w "%{http_code}" -A "sqlmap" "$BASE$1")
  if [[ ! "$code" =~ ^4 ]]; then echo "FAIL $1 -> $code"; exit 1; fi
  echo "OK  $1 -> $code"
}
expect_block "/wp-login.php"
expect_block "/.env"
expect_block "/static/../../../etc/passwd"
