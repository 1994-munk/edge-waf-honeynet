# Cowrie SSH honeypot

We deploy the upstream `cowrie/cowrie:latest` image and only override
`userdb.txt` and the welcome banner. Logs are shipped via the `output_json`
plugin and consumed by the same alert pipeline as the WAF.

Sample userdb (intentionally too easy):
```
root:x:!root
root:x:!123456
root:x:!password
admin:x:*
```
