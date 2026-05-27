# edge-waf-honeynet

A small edge security lab: a WAF in front of a deliberately-bait HTTP
honeypot, plus an SSH honeypot, plus the detection and response glue
that turns their logs into useful signal.

The point is to make this look and feel like a real edge security stack
you'd run alongside a CDN: defense in depth, signed and reviewed rule
changes, alerting that humans can actually act on, and runbooks for the
incidents the system is designed to generate.

## What's inside

- **Nginx + ModSecurity (CRS)** WAF as the public entrypoint
- **fail2ban** to ban repeat offenders at the kernel firewall
- **HTTP honeypot** that pretends to be vulnerable WordPress + phpMyAdmin
- **Cowrie SSH honeypot** to capture credential-stuffing sessions
- **Sigma detection rules** for the alerts we actually want to wake up to
- **Ansible** to roll changes safely across edge nodes
- **CI** that lints Sigma, validates Nginx, and dry-runs ModSec rules

## Quick start

```
docker compose up -d
./scripts/attack_replay.sh        # generates the kinds of traffic we expect
./scripts/show_alerts.sh
```
