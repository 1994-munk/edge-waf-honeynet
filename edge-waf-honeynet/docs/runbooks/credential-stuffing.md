# Runbook: Credential stuffing detected

**Alert:** `ssh_bruteforce` Sigma rule fires (>20 failed logins / 5m / IP).

## 1. Confirm
- `./scripts/show_alerts.sh` → check Banned IP list under `cowrie-bruteforce`.
- Pull last hour of cowrie events for that IP:
  ```
  docker exec ssh-honeypot jq 'select(.src_ip=="<IP>")' /var/log/cowrie/cowrie.json
  ```

## 2. Contain
- fail2ban has already banned the IP at the firewall.
- If the IP belongs to a known cloud range, escalate to the abuse contact.

## 3. Triage real impact
- Search real auth logs for the same IP and any of the bait creds:
  `password_hash = sha256('hunter2-bait')`. Any hit = compromise; rotate.

## 4. Long-tail
- If we see the same ASN repeatedly, propose a wider block in
  `local-overrides.conf` via PR (peer review required).
