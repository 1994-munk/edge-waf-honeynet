# Threat model (STRIDE, edge-focused)

| Asset                 | Threat        | Mitigation in this repo                                  |
|-----------------------|---------------|----------------------------------------------------------|
| Origin web app        | Spoofing      | mTLS edge -> origin (see ansible role)                   |
| Customer requests     | Tampering     | TLS termination at edge; HSTS; strict header rewriting   |
| Edge node             | Repudiation   | Append-only JSON access + audit log shipping             |
| Origin & cache        | Info disclosure | WAF rules block path traversal, SSRF, SQLi via CRS     |
| Edge node             | DoS           | rate limiting, fail2ban, conn caps                       |
| Edge -> origin        | EoP           | Per-PoP service account, least-privilege firewall        |

## Out of scope (on purpose)
- Bot management beyond fail2ban heuristics
- DDoS scrubbing (would need upstream BGP blackholing)
- DLP / response-side scanning
