<!-- HEADER -->
<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:ef4444,100:7c3aed&height=200&section=header&text=edge-waf-honeynet&fontSize=52&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=Edge%20WAF%20%2B%20honeypots%20%2B%20detection%20rules%20on%20Linux&descAlignY=60&descSize=16" alt="header"/>
</p>

<p align="center">
  <a href="https://github.com/1994-munk/edge-waf-honeynet"><img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&size=20&duration=2800&pause=900&color=EF4444&center=true&vCenter=true&width=760&lines=ModSecurity+%2B+OWASP+CRS+at+the+edge;Cowrie+%2B+Dionaea+honeypots+feeding+threat+intel;fail2ban+%2B+nftables+auto-mitigation;Suricata+rules%2C+Grafana+dashboards%2C+runbooks" alt="typing"/></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/ModSecurity-005571?style=for-the-badge&logo=apache&logoColor=white"/>
  <img src="https://img.shields.io/badge/OWASP_CRS-000000?style=for-the-badge&logo=owasp&logoColor=white"/>
  <img src="https://img.shields.io/badge/Suricata-EF4444?style=for-the-badge&logo=wireshark&logoColor=white"/>
  <img src="https://img.shields.io/badge/fail2ban-1f2937?style=for-the-badge&logo=gnubash&logoColor=white"/>
  <img src="https://img.shields.io/badge/nftables-FCC624?style=for-the-badge&logo=linux&logoColor=black"/>
  <img src="https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white"/>
</p>

<p align="center">
  <img src="https://img.shields.io/github/last-commit/1994-munk/edge-waf-honeynet?style=flat-square&color=ef4444"/>
  <img src="https://img.shields.io/github/languages/top/1994-munk/edge-waf-honeynet?style=flat-square&color=7c3aed"/>
  <img src="https://img.shields.io/github/repo-size/1994-munk/edge-waf-honeynet?style=flat-square&color=22c55e"/>
  <img src="https://img.shields.io/badge/status-active-success?style=flat-square"/>
  <img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square"/>
</p>

---

## ✦ What this is

A small but realistic **edge security stack**: a WAF in front of an origin, low- and medium-interaction honeypots beside it, and a detection + mitigation pipeline that ties them together. Built to show what a Senior Network Engineer at a CDN does when traffic gets weird — block fast, learn fast, document.

> Attack the lab on purpose. Watch the rules fire. Read the runbook. Tune.

---

## ✦ Architecture

```
                       ┌──────────────────────────┐
       internet ─────► │  Nginx + ModSecurity     │ ─► origin
                       │  (OWASP CRS, custom rules)│
                       └──────────┬───────────────┘
                                  │ mirrored / tarpit
                                  ▼
                       ┌──────────────────────────┐
                       │  Honeynet                │
                       │  Cowrie (SSH) · Dionaea  │
                       └──────────┬───────────────┘
                                  ▼
                       Suricata ──► alerts ──► fail2ban / nftables
                                       │
                                       ▼
                                Prometheus + Grafana
```

- **Edge WAF:** Nginx + ModSecurity v3 with OWASP CRS, tuned with false-positive runbook
- **Honeypots:** Cowrie (SSH/Telnet), Dionaea (SMB/HTTP), isolated VLAN
- **IDS:** Suricata on the span/mirror with custom rules for the honeynet
- **Mitigation:** fail2ban → nftables drop sets, with TTL'd bans
- **Threat intel:** rotating notes in `docs/threat-intel/` from honeypot captures

---

## ✦ Quick start

```bash
git clone https://github.com/1994-munk/edge-waf-honeynet.git
cd edge-waf-honeynet
docker compose up -d
./scripts/attack-simulator.sh sqli xss path-traversal
open http://localhost:3000        # Grafana → "Edge Security"
```

Tail the WAF in real time:

```bash
docker compose logs -f waf | grep -E "id \"9[0-9]{5}\""
```

---

## ✦ Detections shipped

| Class | Rule source | Example signal |
|---|---|---|
| SQLi / XSS / RCE | OWASP CRS 4.x | `CRS 942100`, `941100` |
| Credential stuffing | custom Lua + ModSec | repeated 401s / IP / minute |
| SSH brute force | Cowrie + fail2ban | `cowrie.login.failed` ≥ N |
| Recon scans | Suricata | ET SCAN sigs + honeypot hits |
| C2 callbacks | Suricata + DNS log | rare TLD + low-rep IP |

---

## ✦ Runbooks

- `docs/runbooks/waf-false-positive.md` — how to whitelist without weakening CRS
- `docs/runbooks/incident-triage.md` — first 15 minutes of a live alert
- `docs/runbooks/honeypot-rotation.md` — rebuilding burnt honeypots safely

---

## ✦ Roadmap

- [x] ModSecurity v3 + OWASP CRS at the edge
- [x] Cowrie + Dionaea honeynet
- [x] Suricata + fail2ban + nftables auto-mitigation
- [ ] CrowdSec integration for crowd-sourced bans
- [ ] eBPF-based L4 rate limiting
- [ ] Auto-generated weekly threat-intel report

---

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:7c3aed,100:ef4444&height=110&section=footer"/>
</p>
