# Runbook: WAF false positive

A customer reports legitimate traffic being blocked.

## 1. Reproduce
- Get a sample request (curl or HAR file). Replay against staging edge.

## 2. Find the rule
- Tail `sec.json`, look for the `id:` of the rule that fired.

## 3. Propose a tuning PR
- Edit `modsec/rules/local-overrides.conf` with the smallest possible
  exception (path-specific, header-specific, never a blanket disable).
- Add a comment with the date and link to the report.
- CI must pass. At least one reviewer must sign off.

## 4. Roll out
- `ansible-playbook -i ansible/inventory/lab.yml ansible/site.yml`
- Confirm with `./tests/waf_blocks.sh` that other rules still fire.
