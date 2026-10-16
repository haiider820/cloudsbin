# CloudsBin Mobile API — Flutter Guide (v1)

> **Provenance — read this first.** Every request/response in this file is a
> REAL response captured live on 2026-10-16 from the app running locally
> (Apache + PHP 8.2 + MySQL), branch `feature/mobile-api`, using the test
> fixture accounts (`mobile-user@test.local`, `u3-other@test.local`,
> `mobile-admin@test.local`). Nothing is invented. Secrets (tokens,
> passwords, credentials, IPs, wallet addresses) are shown as `<redacted>`.
> Anything never seen in a real response is marked **UNVERIFIED** and comes
> from code reading only. Raw captures live outside the repo (test-run
> artifacts, never committed).
>
> Companion files: `openapi.yaml` (machine spec, synced in the same pass),
> `requests.http` (every call ready to run), `COVERAGE.md` (screen coverage).

## 1. Base URL, versioning, headers

- Base URL: `https://<host>/api/v1`. Dev: `http://127.0.0.1/hostphp/api/v1`.
  There is no other version; breaking changes would ship as `/api/v2`.
- Production requires HTTPS. Plain HTTP outside loopback is refused with
  `403 INSECURE_TRANSPORT` (localhost/`127.0.0.1` are exempt so the
  dev machine keeps working). **UNVERIFIED** live (only loopback probed).
- Required headers:

  | Header | When | Example |
  |---|---|---|
  | `Content-Type: application/json` | every POST with a JSON body | — |
  | `Authorization: Bearer <access_token>` | everything except `GET /meta`, `POST auth/register`, `POST auth/login`, `POST auth/refresh`, `POST auth/password-forgot` | `Bearer <redacted>` |
  | `Idempotency-Key: <key>` | money-creating POSTs: `servers/create`, `orders/receipt`, `crypto/checkout`. 8–80 chars `[A-Za-z0-9._:-]`, missing/malformed → 400 | `u3-destroy-d-0001` |
  | `X-Reauth-Token: <grant>` | `servers/credentials-reveal`, `servers/credentials-regenerate`, `servers/destroy` | `<redacted>` |
  | `X-App-Version: <semver>` | optional. Compared against `min_app_version` (currently `0.0.0`, gate dormant). Below minimum → 426 | `1.0.0` |

- `Accept` is not checked; JSON is always returned as `Content-Type: application/json`.
- Response headers on EVERY response: `X-Request-Id: <16 hex>` (quote this
  in bug reports; the same id is written into `logs/security.log`),
  `Cache-Control: no-store`. The API never sets cookies (`Set-Cookie`
  absent — verified on 200, 401 and 405 responses). `405` carries
  `Allow: <verbs>`. `429` carries `Retry-After: <seconds>`.
- Token format: opaque random hex strings, SHA-256 hashed at rest (not
  JWT — the app cannot decode them, it must store them). Observed:
  access token 64 hex, refresh token 128 hex, reauth grant 64 hex.
  The plaintext is returned **once** (login/refresh/reauth) and never again.

## 2. Auth flow

### 2.1 Register — `POST /auth/register` → always 202, never tokens

```json
// REQUEST
{"full_name":"Guide Probe","email":"guide-probe@test.local","password":"<redacted>","password_confirm":"<redacted>","accept_terms":true}
// RESPONSE 202 (identical for new AND already-registered emails — no enumeration)
{"message":"If this email is not already registered, the account has been created. You can now sign in."}
```

Rules (all 400 `VALIDATION_FAILED` unless noted): `full_name` required
(≤100, validated but **not stored** — `users` has no such column);
valid email; password ≥ 8 chars; `password_confirm` must match;
`accept_terms` must be literally `true` (`requireBool`: `true`/`1`/`"1"`);
optional `ref` referral code (≤20). Then call login. Rate limit 10/300s.

### 2.2 Login — `POST /auth/login` (and `/admin/auth/login`)

```json
// REQUEST
{"email":"mobile-user@test.local","password":"<redacted>","device":{"id":"guide-a","platform":"android","app_version":"1.0.0"}}
// RESPONSE 200
{"access_token":"<redacted>","access_expires_at":"2026-10-16T10:19:07Z","refresh_token":"<redacted>","refresh_expires_at":"2026-11-15T10:04:07Z","user":{"id":900152,"email":"mobile-user@test.local","role":"user","created_at":"2026-10-12T08:18:39Z"}}
```

- `device.id` (≤64) is required and should be a stable per-install UUID —
  one **session** is created per login (multi-device = multi-session, see
  `auth/sessions`). `device.name` (≤100) optional. `platform` must be
  `android`/`ios` when present. `app_version` (≤32) is recorded for the
  update gate.
- Any credential failure answers the SAME generic `401` (no enumeration,
  and a non-admin on `/admin/auth/login` gets the identical body):
  `{"error":"Invalid email or password.","code":"AUTH_REQUIRED","request_id":"<redacted>"}`
- Rate limit 5/300s per IP + e-mail. Wrong verb → 405 (`Allow: POST`).
  Malformed JSON → 400 `INVALID_JSON`.

### 2.3 Token lifetimes

| | user audience | admin audience |
|---|---|---|
| access token | 15 min | 10 min |
| refresh token (absolute) | 30 days | 7 days |
| idle timeout (no use at all) | 14 days | 24 hours |
| re-auth grant | 5 min, single use | 5 min, single use |

Lifetimes verified live from `access_expires_at`/`refresh_expires_at`
deltas (user 900s/30d, admin 600s/7d). A token works for **exactly one
audience**: a user token on an admin endpoint (and vice versa) is 401/403.
Demotion takes effect on the next call (role re-read from DB per request).

### 2.4 Refresh — `POST /auth/refresh`

```json
// REQUEST
{"refresh_token":"<redacted>"}
// RESPONSE 200 — new pair; the presented token is consumed (rotated)
{"access_token":"<redacted>","access_expires_at":"2026-10-16T10:19:07Z","refresh_token":"<redacted>","refresh_expires_at":"2026-11-15T10:04:07Z","retried":false}
```

- Rotation does **not** kill the previous access token early: the old
  access token keeps working until its own expiry (verified live).
- ⚠️ Reuse (presenting the already-rotated refresh token, **even
  immediately**) is treated as theft: the session is revoked
  (`refresh_reuse`) and the answer is
  `401 {"error":"Please sign in again.","code":"SESSION_REVOKED"}` —
  observed live. The code contains a 10-second grace path returning
  `retried: true`, but it never triggers (the retry UPDATE matches zero
  rows after rotation), so **`retried: true` is UNVERIFIED** — the app
  must never rely on it.
- Unknown/garbage token → same `401 SESSION_REVOKED`. Expired absolute or
  idle window → `401 SESSION_REVOKED` ("...has expired...").
- Rate limit 30/300s.

### 2.5 What the app must do on 401

| code | meaning | app action |
|---|---|---|
| `AUTH_REQUIRED` | missing token, revoked session (logout, logout-all, revoked device), wrong audience | go to login (no retry possible) |
| `TOKEN_EXPIRED` | access token past `access_expires_at` | `auth/refresh` once; if that 401s → login |
| `SESSION_REVOKED` | refresh expired/idle, reused refresh (theft), revoked session | login (refresh is useless — the session is dead) |

Real expired-token response (expiry forced in DB for the probe):
`401 {"error":"Access token expired.","code":"TOKEN_EXPIRED","request_id":"<redacted>"}`

### 2.6 Sessions — `GET /auth/sessions`, `POST /auth/sessions-revoke`

```json
// GET /auth/sessions → 200 (shape is the standard list envelope; never any token/hash)
{"items":[{"id":228,"device_name":null,"platform":"android","app_version":"1.0.0","last_used_at":"2026-10-16T10:04:05Z","last_ip":"127.0.0.1","created_at":"2026-10-16T10:04:05Z","current":true}],"page":1,"per_page":1,"total":1,"has_more":false}
// POST /auth/sessions-revoke {"session_id":230} → 200
{"revoked":true}
```

`current: true` marks the session the request arrived on. Revoking an
already-revoked but still-owned session answers **200 again** (idempotent).
A foreign or nonexistent id answers `404 {"error":"Session not found.","code":"NOT_FOUND"}`.
"Devices" screen = this list + `sessions-revoke` per row.

### 2.7 Logout — `POST /auth/logout`, `POST /auth/logout-all`

```json
// POST /auth/logout → 200 (this session dies immediately; access tokens deleted)
{"logged_out":true}
// POST /auth/logout-all → 200
{"revoked":16}
```

After logout the token answers `401 AUTH_REQUIRED` (verified live).
`logout-all` revokes every session of the user **in that audience** and
returns the count. Same paths exist under `/admin/auth/*`.

### 2.8 Password forgot — `POST /auth/password-forgot` → 202, not implemented

```json
// REQUEST {"email":"mobile-user@test.local"} — any body or none
// RESPONSE 202 (neutral; no mail is sent anywhere)
{"message":"If that email is registered, password reset instructions will be sent."}
```

Rate limit 3/hour. There is no reset-password endpoint in v1.

## 3. Re-auth grants (step-up for dangerous actions)

Sensitive endpoints — `servers/credentials-reveal`,
`servers/credentials-regenerate`, `servers/destroy` — need, **in addition
to the Bearer token**, a single-use grant:

```json
// POST /auth/reauth {"password":"<redacted>"} → 200
{"reauth_token":"<redacted>","expires_at":"2026-10-16T10:09:08Z"}
// then: X-Reauth-Token: <redacted>  (expires_at − now = 300 s, verified live)
```

- The grant is bound to the session, expires in 5 minutes, and is consumed
  atomically on first use. Missing/expired/used/another-session grant →
  `403 {"error":"This action requires a recent password confirmation.","code":"REAUTH_REQUIRED"}`.
- Wrong password on mint → **`403`** (not 401):
  `{"error":"Invalid password.","code":"FORBIDDEN"}`. Rate limit 5/300s.
- Same flow exists for admins (`POST /admin/auth/reauth`, verified live 200).
- UX pattern: password bottom-sheet → mint grant → immediately fire the
  dangerous call with the grant. Never store grants.

## 4. Error envelope and codes

Failure shape (always): `{"error":"<human>","code":"<MACHINE>","request_id":"<16hex>"}`.
HTTP status carries the class; `code` carries the case. Error bodies are
also `Cache-Control: no-store` with an `X-Request-Id`.

| code | HTTP | meaning | app action |
|---|---|---|---|
| `AUTH_REQUIRED` | 401 | no/invalid/revoked token, wrong audience | login |
| `TOKEN_EXPIRED` | 401 | access token past expiry | refresh once, else login |
| `SESSION_REVOKED` | 401 | refresh dead/rotated/reused, session revoked/expired | login |
| `FORBIDDEN` | 403 | wrong password on `auth/reauth`; (also wrong audience/role) | re-ask password / login |
| `REAUTH_REQUIRED` | 403 | dangerous endpoint without a usable grant | mint grant (password sheet) |
| `INSECURE_TRANSPORT` | 403 | plain HTTP in prod | **UNVERIFIED** live — use HTTPS |
| `VALIDATION_FAILED` | 400 | bad/missing field or param (message names it) | fix input, show `error` |
| `INVALID_JSON` | 400 | malformed JSON body | client bug |
| `METHOD_NOT_ALLOWED` | 405 | wrong verb (`Allow` header lists verbs) | client bug |
| `NOT_FOUND` | 404 | unknown id **or another user's** (never 403 — ids can't be probed) | treat as "gone/never existed" |
| `SERVER_NOT_FOUND` | 404 | same, from regenerate/destroy services | same as NOT_FOUND |
| `NO_CREDENTIALS` | 404 | active server, nothing stored to reveal | offer regenerate |
| `ORDER_NOT_FOUND` | 404 | unknown/not-owned crypto order | same as NOT_FOUND |
| `CONFIRM_REQUIRED` | 400 | destroy without literal `confirm: true` | show the irreversible-action sheet |
| `CONFLICT` | 409 | destroy an already-destroyed server | refresh state |
| `SERVER_NOT_ACTIVE` | 409 | reveal/regenerate needs `status: active` | show "not ready yet" + refresh |
| `ORDER_NOT_ACTIVE` | 403 | regenerate while the order isn't active | contact support flow |
| `USAGE_UNAVAILABLE` | 409 | usage: no provider instance, or provider call failed | show "unavailable", retry later |
| `NO_INSTANCE` | 400 | whitelist/firewall/access-port: no provider instance | show "not ready yet" |
| `INVALID_CIDR` | 400 | bad IP/CIDR, or the world range on whitelist-add | fix input |
| `INVALID_AUTH_TYPE` | 400 | reveal `auth_type` not in `password\|ttyd\|vnc\|rdp` | client bug |
| `ACCESS_PORT_CONFLICT` | 400 | inbound TCP covering the access port | pick another port |
| `DIRECTION_NOT_SUPPORTED` | 400 | firewall `direction` ≠ inbound | client bug |
| `ALREADY_OPEN` | 400 | rule covered by the default firewall | show "already open" |
| `ALREADY_EXISTS` | 409 | identical whitelist rule / firewall rule stored | treat as success |
| `SAME_PORT` | 409 | access-port change to the current port | treat as no-op success |
| `NOT_ACTIVE` | 409 | access-port change while not active | show "not ready yet" |
| `BUSY` | 409 | access-port change already in progress | poll, don't resubmit |
| `RATE_LIMITED` | 429/409 | limiter 429 (+`Retry-After`); access-port per-server daily budget is 409 | back off; honor `Retry-After` |
| `INSUFFICIENT_BALANCE` | 402 | wallet can't cover the plan (nothing debited) | top-up flow |
| `INVALID_PLAN` | 400 | unknown/inactive plan (also receipt) | reload plans |
| `INVALID_REGION` | 400 | unknown/inactive region | reload regions |
| `INVALID_SPECS` | 400 | custom-build specs ≤ 0 | fix input |
| `MISSING_CUSTOM_SPECS` | 400 | `plan_slug: custom` without specs | fix input |
| `INVALID_SSH_PUBLIC_KEY` | 400 | missing SSH key on create | ask for key |
| `NO_MATCHING_PROVIDER` | 400 | no plan matches custom specs | adjust specs |
| `RECEIPT_REQUIRED` | 400 | receipt upload without a file | attach file |
| `RECEIPT_TYPE_INVALID` | 400 | not JPG/PNG/WEBP/PDF (sniffed, not extension) | fix file |
| `RECEIPT_TOO_LARGE` | 400 | > 5 MB | **UNVERIFIED** live (limit from code) |
| `UPLOAD_FAILED` / `UPLOAD_SAVE_FAILED` | 400/500 | upload plumbing failed | **UNVERIFIED** live, retry |
| `ASSET_UNAVAILABLE` | 400 | crypto asset/chain not enabled | pick another asset |
| `BTC_RATE_UNAVAILABLE` | 400 | crypto pricing missing a rate | **UNVERIFIED** live, retry later |
| `IDEMPOTENCY_MISMATCH` | 422 | key reused with a different body | new key, resubmit |
| `PROVIDER_ERROR` | 500/503 | cloud call failed (regenerate 503, access-port fake 500) | retry later; do NOT blindly retry money calls (use idempotency) |
| `SERVER_ERROR` / `DB_ERROR` | 500 | generic / database failure | **UNVERIFIED** live, retry later |
| `APP_UPDATE_REQUIRED` | 426 | `X-App-Version` below minimum | **UNVERIFIED** live (gate dormant, min `0.0.0`) — force update |
| `CREDENTIALS_INVALID` | 409 | legacy `invalid_orphaned` rows | unreachable by design (rows are filtered to `NO_CREDENTIALS`) — dead branch kept verbatim |
| `INVALID_DIRECTION` | 400 | service-level direction guard | unreachable via mobile (controller answers `DIRECTION_NOT_SUPPORTED` first) |

Removed-from-spec (spec-only, never emitted): `INVALID_SERVER_ID`,
`SERVER_NOT_FOUND` (except regenerate/destroy services),
`RULE_NOT_FOUND`, `CREDENTIAL_NOT_FOUND`, `ALREADY_DESTROYED`,
`ALREADY_CLOSED`, `NOT_ACTIVE` (whitelist/firewall GET),
`MISSING_IP`, `INVALID_PROTOCOL`, `INVALID_PORT` (firewall-add uses
`VALIDATION_FAILED`/`INVALID_PORT` only from range checks —
`INVALID_PORT` **is** emitted by access-port range guard and kept above),
`INVALID_DIRECTION`. Real codes verified above replace them.

## 5. Cross-cutting formats

- **Pagination**: `{items:[...], page, per_page, total, has_more}`.
  `servers/list`: default 20, cap 50 (verified `per_page=5` → 5 items,
  `has_more:true`). `orders/list`: default 25, cap 50.
- **Rate limits** (budgets from code; 429 + `Retry-After: <window>` verified
  live on the usage force budget):
  login 5/300s per IP+email · register 10/300s · refresh 30/300s ·
  reauth 5/300s · password-forgot 3/3600s · `mobile_server_refresh` 20/300s ·
  `mobile_usage_force` 10/300s (spent even on failing calls) ·
  reveal 10/300s · regenerate 5/300s · destroy 10/300s · ip_add/remove
  30/300s · firewall_add/remove 30/300s · access_port 10/300s ·
  crypto_checkout 20/300s · access-port max 3 queued changes/server/day
  (409 `RATE_LIMITED`) · idempotency rows pruned after 48h.
- **Dates**: ISO-8601 UTC `...Z` everywhere **except** `crypto/order`
  (`created_at`/`expires_at`/`verified_at` are `Y-m-d H:i:s`) and
  `crypto/assets` `btc_rate.updated_at` (same).
- **Money**: integer **cents** in `*_cents` fields (server-computed, never
  trust client math). Wallet USD (`DECIMAL`) arrives as **strings**:
  `"available_usd":"84.00"`. `usd_pkr_rate` is a number (`280`).
  Crypto amounts are strings (`"8.442150"`). `price_display` is a
  display-only string (`"$5.75"`).
- **Enums observed live**:
  - server `status`: `provisioning`, `booting`, `active`, `destroyed`
    (code also references `password_pending`, `suspended`, `terminated`,
    `failed`, `scaling` — **UNVERIFIED** live);
  - `payment_requests.status`: `pending`, `server_created`, `rejected`
    (web flow adds more — **UNVERIFIED** via mobile);
  - `orders.status`: `active`, `cancelled`;
  - `crypto_payments.status`: `PENDING`, `PAID`, `EXPIRED`;
  - reveal `auth_type`: `password`, `ttyd`, `vnc`, `rdp`
    (`invalid_orphaned` = legacy filtered rows);
  - `platform`: `android`, `ios`; firewall `direction`: `inbound` only;
    `protocol`: `tcp`, `udp`.

## 6. Endpoint reference

Conventions below: `auth: —` means no token; `auth: user/admin` means that
audience's Bearer token. Every example is a real captured response with
secrets replaced by `<redacted>`. `request_id` values are redacted the same
way (always 16 hex).

### 6.1 `GET /meta` — public discovery · auth: —

```json
// RESPONSE 200
{"server_time":"2026-10-16T10:04:04Z","api_version":"v1","min_app_version":"0.0.0","https":false,"allow_insecure":true}
```

| field | type | nullable | example | meaning |
|---|---|---|---|---|
| server_time | string(datetime) | no | `2026-10-16T10:04:04Z` | server clock, ISO-8601 |
| api_version | string | no | `v1` | — |
| min_app_version | string | no | `0.0.0` | below this → 426 (dormant) |
| https | bool | no | `false` | whether this request arrived over TLS |
| allow_insecure | bool | no | `true` | dev/test HTTP allowed |

Errors: `405` wrong verb · `403 INSECURE_TRANSPORT` (non-loopback HTTP).

### 6.2 `POST /auth/register` — auth: — · rate 10/300s

Request: `{full_name≤100, email≤190, password 8..200, password_confirm, accept_terms:true, ref?≤20}`.
Success is §2.1 (always 202, neutral). Real error:
`400 {"error":"Missing or invalid field: accept_terms","code":"VALIDATION_FAILED","request_id":"<redacted>"}`.
No other success shape exists.

### 6.3 `POST /auth/login` — auth: — · rate 5/300s per IP+email

Request: `{email, password, device:{id(req,≤64, stable install UUID), name?, platform android|ios, app_version?}}`.
Success §2.2. Real errors: `401 AUTH_REQUIRED` (generic — bad password,
unknown email, or non-admin on `/admin/auth/login`, all identical);
`400 VALIDATION_FAILED` (bad email/platform/device); `400 INVALID_JSON`;
`405` (`Allow: POST`); `429`.

| field | type | nullable | example | meaning |
|---|---|---|---|---|
| access_token | string | no | `<redacted>` (64 hex) | Bearer for API calls |
| access_expires_at | string(datetime) | no | `...+15min` | — |
| refresh_token | string | no | `<redacted>` (128 hex) | rotation credential |
| refresh_expires_at | string(datetime) | no | `...+30d` | absolute expiry |
| user.id / .email / .role / .created_at | int/string/enum/datetime | no | `900152` / `mobile-user@test.local` / `user` | no `full_name`, no `referral_code` here |

### 6.4 `POST /auth/refresh` — auth: — · rate 30/300s

Request `{refresh_token}`. Success §2.4 (`retried:false` normal path).
Real errors: `400 VALIDATION_FAILED` (missing); `401 SESSION_REVOKED`
(garbage, expired, idle-timeout, **or any reuse** — session dies, go to
login); `429`. `retried:true` UNVERIFIED (see §2.4).

### 6.5 `POST /auth/logout`, `POST /auth/logout-all` — auth: user (admin variants identical)

```json
// logout → 200 {"logged_out":true}
// logout-all → 200 {"revoked":16}
```

No body. After either, the token(s) answer `401 AUTH_REQUIRED`.
`revoked` = sessions killed in this audience (int, includes current).

### 6.6 `GET /auth/sessions` — auth: user · `POST /auth/sessions-revoke`

List shape = standard envelope (§5); item: `{id, device_name|null,
platform android|ios|null, app_version|null, last_used_at, last_ip,
created_at, current}` — never tokens/hashes. Revoke request
`{session_id}` → `200 {"revoked":true}` (idempotent — repeat is 200);
foreign/unknown id → `404 NOT_FOUND "Session not found."`;
bad id → `400 VALIDATION_FAILED`.

### 6.7 `POST /auth/reauth` — auth: user · rate 5/300s

Request `{password}` → `200 {"reauth_token":"<redacted>","expires_at":"<redacted>"}` (TTL 300 s, verified).
Wrong password → `403 FORBIDDEN "Invalid password."`. See §3.

### 6.8 `POST /auth/password-forgot` — auth: — · rate 3/hour

Any/empty JSON body → `202 {"message":"If that email is registered, password reset instructions will be sent."}`.
Nothing is sent; no reset endpoint exists. `429` after 3/hour.

### 6.9 `GET /me`, `GET /admin/me` — auth: user / admin

```json
// RESPONSE 200
{"id":900152,"email":"mobile-user@test.local","role":"user","created_at":"2026-10-12T08:18:39Z","referral_code":"A2FAAA6E"}
```

| field | type | nullable | example | meaning |
|---|---|---|---|---|
| id / email / role / created_at | int/string/enum/datetime | no | — | `role` is `user` or `admin` |
| referral_code | string | yes | `A2FAAA6E` | null when none (admin fixture) |

Errors: `401` (missing/invalid/expired — codes `AUTH_REQUIRED` /
`TOKEN_EXPIRED` / `SESSION_REVOKED`); user token on `/admin/me` → 403.

### 6.10 `GET /home` — auth: user (dashboard summary)

```json
// RESPONSE 200
{"servers":{"total":7,"active":3,"provisioning":1,"other":3},"wallet":{"available_usd":"84.00","pending_usd":"0.00","lifetime_earned_usd":"50.00"},"unread_notifications":1,"pending_topups":0}
```

| field | type | nullable | example | meaning |
|---|---|---|---|---|
| servers.total/active/provisioning/other | int | no | `7/3/1/3` | `other` = neither active nor provisioning |
| wallet.available_usd/pending_usd/lifetime_earned_usd | string | no | `"84.00"` | DECIMAL-as-string USD, never float |
| unread_notifications / pending_topups | int | no | `1/0` | badges |

Errors: `401` only.

### 6.11 `GET /plans/list` — auth: user

Envelope (§5) + `usd_pkr_rate: 280` (number) alongside. Item:
```json
{"slug":"aws-t3a-nano-linux","name":"Starter Linux","display_name":"Starter Linux","description":"Linux with browser terminal · 2 vCPU · 0.5 GB RAM","vcpu":2,"ram_gb":0.5,"ssd_gb":20,"specs":{"vcpu_label":"2 vCPU","ram_label":"0.5 GB RAM","ssd_label":"20 GB SSD","transfer":"1 TB"},"price_cents":350,"eip_price_cents":250,"autoscale_offered":false,"autoscale_max_slug":null,"regions":[{"slug":"us-east","display_name":"US East"}]}
```

| field | type | nullable | example | meaning |
|---|---|---|---|---|
| slug | string | no | `nano` | the app's plan identifier (buy with this) |
| name / display_name / description | string | no/nullable desc | `Starter` | display strings |
| vcpu (int) / ram_gb (number) / ssd_gb (int) | number | ram/ssd nullable | `1` / `1` / `25` | specs |
| specs.{vcpu,ram,ssd}_label, transfer | string | yes | `1 vCPU` | pricing-page labels |
| price_cents / eip_price_cents | int | eip nullable | `800` / `0` | integer cents |
| autoscale_offered / autoscale_max_slug | bool/string | max nullable | `false` | — |
| regions[] {slug, display_name} | array | no | `us-east` | where it can be bought |

Provider fields are absent by design (no `provider_*` anywhere).
Errors: `401` only.

### 6.12 `GET /regions/list` — auth: user

```json
{"items":[{"slug":"us-east","display_name":"US East"},{"slug":"us-west","display_name":"US West"},{"slug":"europe","display_name":"Europe"},{"slug":"asia","display_name":"Asia Pacific"}],"page":1,"per_page":4,"total":4,"has_more":false}
```

Only regions some active provider can serve. Errors: `401` only.

### 6.13 `GET /images/list?plan_id=&region=` — auth: user

`plan_id` carries the plan **slug** (`plan` alias accepted); `region` optional.

```json
// plan_id=nano → 200 (truncated; 24 images)
{"default":"linode/ubuntu26.04","images":[{"slug":"linode/ubuntu22.04","name":"Ubuntu 22.04 LTS"},{"slug":"linode/ubuntu24.04","name":"Ubuntu 24.04 LTS"}]}
// plan with no mapped images → 200 {"default":null,"images":[]}
```

Real errors: no `plan_id` → `400 VALIDATION_FAILED "Missing required
parameter: plan_id"`; unknown plan → `404 NOT_FOUND "Plan not found."`;
region the plan can't serve → `409 CONFLICT "That region is not available
for the selected plan."`.

### 6.14 `POST /servers/estimate` — auth: user (no money moves)

Request `{vcpu>0, ram_gb>0, ssd_gb>0, region slug | region_id}`.
```json
// RESPONSE 200
{"price_cents":575,"price_display":"$5.75","vcpu":1,"ram_gb":1,"ssd_gb":25,"included_ssd":25,"region":"US East","region_slug":"us-east"}
```
Real errors: zeros → `400 INVALID_SPECS "Invalid specs provided."`;
bad region → `400 INVALID_REGION`; unmatchable specs →
`400 NO_MATCHING_PROVIDER`; bad JSON → `400 INVALID_JSON`.

### 6.15 `POST /servers/create` — auth: user · `Idempotency-Key` required · wallet debit

```json
// REQUEST
{"plan_slug":"nano","region":"us-east","ssh_public_key":"ssh-ed25519 <redacted>"}
// RESPONSE 201
{"server_id":9206573,"status":"provisioning","payment_request_id":422,"plan_name":"nano","price_cents":800,"eip_price_cents":0,"total_cents":800,"autoscale":false}
```

Request notes: `plan_slug` (or numeric `plan_id`), `region` slug
(required), `image` slug optional (defaults server-side), `autoscale`
bool, `plan_slug:"custom"` + `custom_specs{vcpu,ram_gb,ssd_gb}` for custom
builds. Any price field is ignored — price is server-computed, debited
from the wallet in one transaction. `status` is `provisioning` (then poll
`servers/refresh` or list progress). No provider/instance fields ever.

Idempotency (verified live): same key+body → `201` **byte-identical
body** + `Idempotent-Replay: true` header, no new server, no new debit;
same key + different body → `422 {"error":"This Idempotency-Key was
already used with a different request body.","code":"IDEMPOTENCY_MISMATCH"}`;
key in flight → `409 CONFLICT` (timing — code-level, UNVERIFIED live).

Real errors: no/malformed key → `400 VALIDATION_FAILED`;
`400 INVALID_PLAN / INVALID_REGION ("A valid region is required.") /
MISSING_CUSTOM_SPECS / INVALID_SSH_PUBLIC_KEY`;
`402 {"error":"Insufficient wallet balance for this plan.","code":"INSUFFICIENT_BALANCE"}`
(zero state change); `405`; `429`.

### 6.16 `GET /servers/list?page=&per_page=` — auth: user

Standard envelope; newest first; `per_page` default 20 cap 50.
```json
{"items":[{"id":9206568,"name":"u3-fx-regen-fake","status":"active","ip_address":"203.0.113.10","access_port":22,"plan_name":null,"region":"us-east","os":"linode/ubuntu22.04","vcpu":null,"ram_gb":1,"ssd_gb":null,"created_at":"2026-10-16T10:04:04Z","activated_at":null,"destroyed_at":null,"progress":100,"stage":null,"eta_seconds":null}],"page":1,"per_page":5,"total":7,"has_more":true}
```
Provisioning rows carry live `progress/stage/eta_seconds` (status poll
showed e.g. `progress:4..97, stage:"building"/"installing",
eta_seconds`, plus `retry_after`). No `provider_*` keys anywhere
(verified by leak greps in the proof). Errors: `401` · `405`.

### 6.17 `GET /servers/detail?id=` — auth: user

List projection + `bandwidth` (best-effort cache row, else null):
```json
{"id":9206565,"name":"u3-fx-reveal","status":"active","ip_address":"203.0.113.10","access_port":22,"plan_name":null,"region":"us-east","os":"linode/ubuntu22.04","vcpu":null,"ram_gb":1,"ssd_gb":null,"created_at":"2026-10-16T10:04:04Z","activated_at":null,"destroyed_at":null,"progress":100,"stage":null,"eta_seconds":null,"bandwidth":null}
```
Real errors: bad id → `400 VALIDATION_FAILED`; unknown/foreign id →
`404 NOT_FOUND "Server not found."` (never 403).

### 6.18 `POST /servers/refresh` — auth: user · rate `mobile_server_refresh` 20/300s

Request `{server_id}`. Active-with-IP servers answer immediately:
```json
// RESPONSE 200 (fast path)
{"id":9206565,"name":null,"status":"active","ip_address":"203.0.113.10","access_port":22,"plan_name":null,"region":"us-east","os":"linode/ubuntu22.04","ram_gb":null,"ssd_gb":null,"created_at":"2026-10-16T10:04:04Z","activated_at":null,"destroyed_at":null,"reconciled":false,"reason":"already_active"}
```
Otherwise it reconciles against the provider and returns
`reconciled:true`. Real errors: `400` · `401` · `404 NOT_FOUND`
(foreign included) · `405` · `429`. (`name`/`ram_gb` may be null on the
fast path when the row lacks them — observed.)

### 6.19 `GET /servers/usage?id=&force=` — auth: user

```json
// RESPONSE 200 (flat, bytes; force=0 served from cache when fresh)
{"bandwidth_in_bytes":0,"bandwidth_out_bytes":0,"total_bytes":0,"limit_bytes":545460846592,"cached":false,"fetched_at":"2026-10-16T10:12:27Z","server_id":9206573}
```
`force=1` bypasses the 1-hour cache (budget 10/300s, spent even on
failures → 11th is `429 RATE_LIMITED` + `Retry-After: 300`).
Real errors: bad id → `400`; unknown/foreign → `404 NOT_FOUND`;
no instance (or provider failure) →
`409 {"error":"Usage is unavailable for this server.","code":"USAGE_UNAVAILABLE"}`.

### 6.20 `POST /servers/credentials-reveal` — auth: user + reauth grant

Request `{server_id, auth_type? = password}` (`auth_type` optional,
defaults to `password`; present-but-unknown → `400 INVALID_AUTH_TYPE`).
```json
// RESPONSE 200 (Cache-Control: no-store; reveal_count++ in DB; both logs get a no-secret line)
{"auth_type":"password","credential":"<redacted>","ip_address":"<redacted>"}
```
Counted, not one-shot: a second reveal with a fresh grant also 200s.
Real errors: no/bad/used/foreign grant → `403 REAUTH_REQUIRED`;
non-active → `409 SERVER_NOT_ACTIVE "Credentials can only be revealed
once a server is active."`; active but nothing stored →
`404 NO_CREDENTIALS "No credentials stored for this server."`;
unknown/foreign → `404 NOT_FOUND`; `400 INVALID_AUTH_TYPE`.

### 6.21 `POST /servers/credentials-regenerate` — auth: user + reauth grant

Request `{server_id}`. Rotates the provider root password and stores only
the encrypted replacement.
```json
// RESPONSE 200 (no credential anywhere — not in body, not in logs)
{"server_id":9206574,"message":"A new root password was generated. Reveal it to see the value."}
```
Real errors: grant → `403 REAUTH_REQUIRED`; unknown/foreign →
`404 SERVER_NOT_FOUND`; non-active → `409 SERVER_NOT_ACTIVE`;
suspended/cancelled order → `403 ORDER_NOT_ACTIVE`; provider failure →
`503 {"error":"Failed to reset this server's password. Please try again
later.","code":"PROVIDER_ERROR"}` (observed live on a seconds-old
instance, Linode answered "Linode busy." — retry later).
Rate 5/300s.

### 6.22 `POST /servers/destroy` — auth: user + reauth grant + `confirm:true`

```json
// REQUEST {"server_id":9206573,"confirm":true}
// RESPONSE 200 (row RETAINED with status destroyed; provider instance deleted)
{"server_id":9206573,"status":"destroyed"}
```
Real errors: grant → `403 REAUTH_REQUIRED`; missing/`false` confirm →
`400 CONFIRM_REQUIRED "This action is irreversible. Send confirm:true to
proceed."`; unknown/foreign → `404 NOT_FOUND`; already destroyed →
`409 CONFLICT`; provider failure → `503 PROVIDER_ERROR`
(code-level, UNVERIFIED live). Abort-safe server-side
(`ignore_user_abort`): killing the client mid-call still destroys.

### 6.23 `GET /servers/ip-whitelist?id=` — auth: user

```json
// empty → 200 {"ips":[],"access_port":22}
// with a row → 200
{"ips":[{"id":56,"ip_cidr":"198.51.100.77/32","port":22,"description":"guide-doc","created_at":"2026-10-16T10:12:37Z"}],"access_port":22}
```
Real errors: bad id → `400`; no instance → `400 NO_INSTANCE "Server has
no provider instance."`; unknown/foreign → `404 NOT_FOUND`.

### 6.24 `POST /servers/ip-whitelist-add` — auth: user · rate 30/300s

Request `{server_id, cidr_or_ip, label?}` (`ip_cidr`/`description`
accepted as aliases; provider call runs before the insert).
```json
// RESPONSE 200
{"message":"IP added to the whitelist.","ip_cidr":"198.51.100.77/32","access_port":22}
```
Real errors: missing →
`400 VALIDATION_FAILED "Missing or invalid field: cidr_or_ip"`;
`"not-an-ip"` → `400 INVALID_CIDR`; `0.0.0.0/0` → `400 INVALID_CIDR`
(world range); duplicate → `409 ALREADY_EXISTS`; no instance →
`400 NO_INSTANCE`; unknown/foreign → `404 NOT_FOUND`.

### 6.25 `POST /servers/ip-whitelist-remove` — auth: user · rate 30/300s

Request `{server_id, rule_id}` (rule `id` from the GET).
```json
// RESPONSE 200
{"message":"IP removed from the whitelist.","rule_id":56,"removed":true}
```
Unknown rule (or foreign server) → `404 NOT_FOUND` ("Whitelist rule not
found." / "Server not found."). Empty whitelist re-opens the platform
default (except AWS Windows RDP).

### 6.26 `POST /servers/access-port` — auth: user · rate 10/300s

Request `{server_id, port}`. Queues an agent command; the guest applies it.
```json
// RESPONSE 200
{"message":"Access-port change queued; the agent applies it within a minute.","access_port":22,"new_port":2244,"server_id":9206573,"command":{"id":3,"step":"open","status":"pending"}}
```
Guards in order: provider supported → instance → active (409
`NOT_ACTIVE`) → **same as current (409 `SAME_PORT` — checked before the
range rules, since the default 22 is below range and reserved)** → range
1024–65535 (`INVALID_PORT`) → reserved list 22/3389/80/443/7681/9000/5901/
6080 (`RESERVED_PORT`) → in-progress change (`BUSY` 409) → 3/day/server
(`RATE_LIMITED` 429). Same-port real: `409 {"error":"That is already this
server's access port.","code":"SAME_PORT"}`. Fake instance →
`500 PROVIDER_ERROR` (provider-first, no command queued).
`RESERVED_PORT`/`INVALID_PORT`/`BUSY`/daily-limit shapes are code-level
(**UNVERIFIED** live — same envelope as `SAME_PORT`).

### 6.27 `GET /servers/firewall?id=` — auth: user (inbound only)

```json
// RESPONSE 200 (empty and with a rule)
{"rules":[],"access_port":22,"directions":["inbound"]}
{"rules":[{"id":92,"direction":"inbound","protocol":"tcp","port_start":8443,"port_end":8443,"ip_cidr":"198.51.100.0/24","description":"guide-doc","created_at":"2026-10-16T10:12:52Z"}],"access_port":22,"directions":["inbound"]}
```
Real errors: `400` (bad id / `NO_INSTANCE`); `404 NOT_FOUND`.

### 6.28 `POST /servers/firewall-add` — auth: user · rate 30/300s

Request `{server_id, direction?=inbound, protocol?=tcp, port | port_start(+port_end) | port_range "8000-8100", source_cidr, description?}`.
```json
// RESPONSE 200
{"message":"Firewall rule added.","direction":"inbound","protocol":"tcp","port_start":8443,"port_end":8443,"source_cidr":"198.51.100.0/24","access_port":22}
```
Real errors: `direction:outbound` →
`400 DIRECTION_NOT_SUPPORTED "Only inbound rules can be managed."`;
TCP covering the access port → `400 ACCESS_PORT_CONFLICT`;
bad CIDR → `400 INVALID_CIDR`; bad protocol/ports →
`400 VALIDATION_FAILED`; baseline-covered world rule →
`400 ALREADY_OPEN "That rule is already covered by the server default
firewall."`; identical stored rule → `409 ALREADY_EXISTS`
(code-level, UNVERIFIED live instance); unknown/foreign → `404 NOT_FOUND`.

### 6.29 `POST /servers/firewall-remove` — auth: user · rate 30/300s

Request `{server_id, rule_id}` →
`200 {"message":"Firewall rule removed.","rule_id":92,"removed":true}`.
Unknown rule/server → `404 NOT_FOUND`.

### 6.30 `GET /orders/list?page=&per_page=` — auth: user (default 25, cap 50)

```json
{"items":[{"id":420,"status":"server_created","plan_slug":"nano","plan_name":"nano","plan_price_cents":800,"eip_price_cents":0,"total_cents":800,"region":"us-east","image":"linode/ubuntu26.04","autoscale":false,"custom_specs":null,"has_receipt":false,"server_id":9206560,"server_status":"destroyed","ip_address":null,"admin_note":"Paid via wallet balance - no admin review needed.","created_at":"2026-10-16T08:13:37Z"}],"page":1,"per_page":25,"total":9,"has_more":false}
```
Customer columns only (`receipt_path` becomes `has_receipt`). Errors: `401` · `405`.

### 6.31 `POST /orders/receipt` — auth: user · `Idempotency-Key` · multipart

Fields `plan_slug, plan_name, price_cents, region?, image?, autoscale?,
custom_specs?` + file field `receipt` (JPG/PNG/WEBP/PDF sniffed by finfo,
≤5 MB; stored random-named, deleted on failure).
```json
// RESPONSE 201 (admin-review flow; no money moves, no provisioning)
{"request_id":421,"status":"pending"}
```
Real errors: no file → `400 RECEIPT_REQUIRED`; wrong type →
`400 RECEIPT_TYPE_INVALID`; bad plan →
`400 INVALID_PLAN "Invalid plan."`; missing specs for custom →
`400 MISSING_CUSTOM_SPECS`; missing key → `400`; mismatch → `422`;
in-flight → `409`. (`RECEIPT_TOO_LARGE`, `UPLOAD_FAILED`,
`UPLOAD_SAVE_FAILED` are code-level, UNVERIFIED live.)

### 6.32 `GET /crypto/assets` — auth: user

```json
// RESPONSE 200 (only admin-enabled assets; BTC row was the live one here)
{"network":"mainnet","is_testnet":false,"assets":[{"asset":"BTC","chain":"BTC","label":"Bitcoin","symbol":"BTC","decimals":8,"network":"mainnet","network_name":"Bitcoin Mainnet","confirmations_required":1}],"btc_rate":{"rate":83280.01,"updated_at":"2026-10-15 11:48:30","age_sec":98140}}
```
Errors: `401` · `405`.

### 6.33 `POST /crypto/checkout` — auth: user · `Idempotency-Key` · rate 20/300s

Request `{plan_slug (or plan_id), plan_name?, region, image?, autoscale?,
custom_specs?, asset?, chain?}` — price server-computed; creates a
PENDING order, no chain activity yet.
```json
// RESPONSE 201
{"message":"Crypto checkout created.","id":71,"order_id":"CRY-76fbd1d8","wallet_address":"<redacted>","amount_requested":"8.442150","asset":"USDT","chain":"TRC20","token_symbol":"USDT","decimals":6,"confirmations_required":0,"network":"mainnet","network_name":"TRON Mainnet","explorer":"https://tronscan.org","expires_in_sec":1800,"checkout_url":"crypto-checkout.php?order=CRY-76fbd1d8"}
```
Real errors: no plan → `400 INVALID_PLAN`; disabled asset →
`400 ASSET_UNAVAILABLE "Selected asset is not available right now."`;
custom without specs → `400 MISSING_CUSTOM_SPECS`; key problems →
`400`/`409`/`422` (same contract as §6.15).
`BTC_RATE_UNAVAILABLE` is code-level (UNVERIFIED live).

### 6.34 `GET /crypto/order?order=CRY-...` — auth: user (ownership in SQL)

```json
// RESPONSE 200 (note: datetimes are "Y-m-d H:i:s", NOT ISO-8601 — the one v1 exception)
{"order_id":"CRY-76fbd1d8","wallet_address":"<redacted>","amount_requested":"8.442150000000000000","amount_received":null,"tx_hash":null,"tx_url":null,"status":"PENDING","asset":"USDT","chain":"TRC20","network":"mainnet","network_name":"TRON Mainnet","explorer":"https://tronscan.org","token_symbol":"USDT","decimals":6,"created_at":"2026-10-16 15:04:10","expires_at":"2026-10-16 15:34:10","verified_at":null,"is_expired":false,"seconds_left":1799,"payment_request_id":null,"provision_status":"none","server_id":null}
```
Unknown/not-owned → `404 ORDER_NOT_FOUND "Order not found."`; missing
param → `400`. (`PAID`/`EXPIRED` shapes: same object, fields filled.)

### 6.35–6.36 `POST /push/register`, `POST /push/unregister` — BROKEN

Observed live: HTTP 200 with a PHP fatal body (`Failed opening required
'.../api/app/bootstrap.php'` — wrong require depth in both entry files).
Intended contract (per code, UNVERIFIED live): `{fcm_token≤255
([A-Za-z0-9_:\-.] 10–255 chars), platform?}` →
`200 {"registered":true}` / `200 {"removed":N}`; bad token →
`400 VALIDATION_FAILED`; provider failure → `503 PROVIDER_UNREACHABLE`.
The app must treat push as unavailable until the entry files are fixed
(same for both `/admin/push/*` endpoints).

### 6.37 Admin auth + `/admin/me` — same shapes, admin audience

`POST /admin/auth/login` (non-admin → identical generic 401),
`POST /admin/auth/refresh` (→ 200 pair + `retried:false`; TTLs 10 min /
7 days verified live), `POST /admin/auth/logout` (`{"logged_out":true}`),
`POST /admin/auth/logout-all` (`{"revoked":N}`),
`GET /admin/auth/sessions` (same envelope/item shape),
`POST /admin/auth/sessions-revoke` (`{"revoked":true}` / 404),
`POST /admin/auth/reauth` (`{"reauth_token","expires_at"}`),
`GET /admin/me` (`{"id":900227,...,"role":"admin",...,"referral_code":null}`).
Error codes identical to the user variants. Demotion revokes admin minting
at refresh (code-level).

## 7. UNVERIFIED inventory (code-level only, never seen live)

Behavioral (entry point broken or unreachable): all four push endpoints
(§6.35–6.36 — HTTP 200 + PHP fatal, fix = correct the bootstrap require
depth); refresh `retried:true` (reuse actually revokes — §2.4);
`CREDENTIALS_INVALID` (dead branch by design);
`INVALID_DIRECTION` (controller answers first);
`ALREADY_DESTROYED` via mobile (controller answers `CONFLICT` first);
`NOT_ACTIVE` on whitelist/firewall GET (no status check in code).

Shapes (same envelope, specific case not exercised): access-port
`RESERVED_PORT` / `INVALID_PORT` / `BUSY` / daily `RATE_LIMITED`;
firewall-add `ALREADY_EXISTS` duplicate; whitelist world-range message
variant; `RECEIPT_TOO_LARGE` / `UPLOAD_FAILED` / `UPLOAD_SAVE_FAILED`;
`BTC_RATE_UNAVAILABLE`; idempotency `409 CONFLICT` in-flight;
`SERVER_ERROR` / `DB_ERROR` 500s; `INSECURE_TRANSPORT` 403 (loopback
exempt); `APP_UPDATE_REQUIRED` 426 (gate dormant); `PAID`/`EXPIRED`
crypto-order field fills; `suspended`/`terminated`/`failed`/`scaling`/
`password_pending` server statuses; non-`pending` payment-request
statuses beyond `server_created`/`rejected`; admin demotion paths.

## 8. What changed in `openapi.yaml` in this pass

The previous spec was audited operation-by-operation against the live
responses above. Fixed: refresh limiter name (`mobile_server_refresh`)
and 200 schema (real projection + `reconciled`/`reason`); usage 200
flattened (no `usage:` wrapper), 404 → `NOT_FOUND`, 409 = instance-or-
provider-failure, 503 removed; detail/refresh/usage/destroy/access-port/
firewall 404s → `NOT_FOUND` (was `SERVER_NOT_FOUND`); detail 400 →
`VALIDATION_FAILED` (was `INVALID_SERVER_ID`); reveal 400/404 codes;
regenerate 200 message = the mobile text, 404 → `SERVER_NOT_FOUND`,
added 403 `ORDER_NOT_ACTIVE`; destroy 200 = `{server_id, status}` (no
`message`), 400/409 → `CONFIRM_REQUIRED`/`VALIDATION_FAILED`/`CONFLICT`;
whitelist GET/add/remove + firewall GET/add/remove code cleanups
(`VALIDATION_FAILED`/`NOT_FOUND`, unreachable `NOT_ACTIVE`/
`ALREADY_CLOSED`/`RULE_NOT_FOUND` removed, `removed:true` added,
`SAME_PORT`/`BUSY`/daily-limit and `port_start`/`port_range` documented,
firewall-add limiter corrected to `mobile_firewall_add` 30/300s);
`ServerSummary`/`ServerDetail`/`ServerUsage` schemas rewritten to the real
wire shapes; crypto assets/checkout/order given concrete schemas
(including the `Y-m-d H:i:s` datetime exception); `TokenPair.user`
marked login-only; refresh description corrected to observed
revoke-on-reuse; sessions-revoke idempotency noted; all four push
endpoints marked BROKEN with the observed fatal.

