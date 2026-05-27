-- Anyone who used our bait .env credentials anywhere on the real network
-- is by definition compromised. We seed `hunter2-bait` into nothing real.
SELECT ts, src_ip, app, user FROM auth_events
WHERE password_hash = sha256('hunter2-bait')
ORDER BY ts DESC
LIMIT 200;
