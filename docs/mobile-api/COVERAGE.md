# Flutter app coverage vs `/api/v1` (proven live 2026-10-16)

Legend: ✅ exists + probed live · ⚠️ exists but broken/500 · ❌ missing
from v1 (a legacy web-session path may exist under `/api/*` — unusable
from Flutter, which has no session cookie).

## USER app

| Screen | ✅ Exists (v1) | ⚠️ / ❌ Gap |
|---|---|---|
| Login / register / sessions | `auth/register`, `auth/login`, `auth/refresh`, `auth/logout`, `auth/logout-all`, `auth/sessions`, `auth/sessions-revoke`, `auth/reauth`, `auth/password-forgot` (neutral 202), `me` | password change/reset: ❌ (forgot is a stub; no reset endpoint) |
| Server list | `servers/list` (progress/ETA in-flight) | — |
| Server detail | `servers/detail` (+`bandwidth`), `servers/refresh` | — |
| Reveal credentials | `servers/credentials-reveal` + reauth grant | — |
| Regenerate | `servers/credentials-regenerate` | — |
| Usage | `servers/usage` (+`force`) | — |
| IP whitelist | `servers/ip-whitelist`, `-add`, `-remove` | — |
| Firewall | `servers/firewall`, `-add`, `-remove` (inbound only) | outbound rules: ❌ by design |
| Access port | `servers/access-port` (queued command) | live success + same-port verified; reserved/busy/daily-limit shapes code-level |
| Destroy | `servers/destroy` (row retained) | — |
| Plans / regions / images | `plans/list`, `regions/list`, `images/list` | — |
| Order a server | `servers/estimate`, `servers/create` (idempotent), `orders/list`, `orders/receipt` | — |
| Crypto pay | `crypto/assets`, `crypto/checkout`, `crypto/order` | pay/verify happens on-chain + admin; app polls `crypto/order` |
| Wallet & payments | `home` balances only (`available/pending/lifetime` strings) | ❌ no v1 wallet endpoints: balance history, top-up, withdraw, cancel-withdrawal, reseller top-up, payment approve/reject all live only as legacy session paths (`api/wallet/*`, `api/reseller/*`, `api/payment-request.php`, `api/admin/*`) |
| Terminal / desktop session | — | ❌ no v1 endpoints (`api/servers/terminal-session.php`, `desktop-session.php` are session+CSRF only) |
| Notifications | count only (`home.unread_notifications`) | ❌ no v1 list; `api/notifications/mark-read.php` session-only; ⚠️ push register/unregister entry files fatal (HTTP 200 + PHP fatal, wrong bootstrap require depth) |
| Support tickets | — | ❌ no v1 endpoints (`api/tickets/*` session-only) |
| Account / devices | `me` (incl. `referral_code`), `auth/sessions*` | password change ❌; referral *redeem* is server-side on register (`ref`) |

## ADMIN app

| Screen | ✅ Exists (v1) | ⚠️ / ❌ Gap |
|---|---|---|
| Admin login / sessions / me | `admin/auth/login`, `/refresh`, `/logout`, `/logout-all`, `/sessions`, `/sessions-revoke`, `/reauth`, `admin/me` | — |
| Admin push | — | ⚠️ both entry files fatal (same require-depth bug) |
| Everything else (users, servers, orders, top-ups, withdrawals, tickets, payments, receipts) | — | ❌ zero v1 management endpoints; legacy `api/admin/*` paths are session-only |

## Spec-but-not-implemented / returns-500 summary

1. `POST /push/register`, `POST /push/unregister`,
   `POST /admin/push/register`, `POST /admin/push/unregister` — in spec,
   fatal over HTTP (require-depth bug). Fix is 1 line per file, no feature
   change: `push/*` need `../../../app/bootstrap.php`, `admin/push/*`
   need `../../../../app/bootstrap.php`.
2. `retried:true` refresh grace — in spec, never succeeds live (retry
   UPDATE matches zero rows; reuse revokes the session). Spec corrected
   to observed behavior.
3. Dead-by-design codes kept in code but unreachable: `CREDENTIALS_INVALID`,
   `INVALID_DIRECTION`, mobile `ALREADY_DESTROYED` (controller answers
   `CONFLICT` first), `RULE_NOT_FOUND`/`SERVER_NOT_FOUND`/`INVALID_SERVER_ID`
   spellings (real: `NOT_FOUND`/`VALIDATION_FAILED`).

## Suggested Flutter build order

`login` (token store + 401 router) → server `list` → `detail` + `refresh`
→ reauth sheet + `reveal` → `usage` → `whitelist` → `firewall` →
`destroy` (+ access-port) → catalog + `estimate` → `create` + `orders`
(+ receipt upload, crypto checkout) → `home`/account/devices →
admin auth shell → **blocked until backend**: push (entry-file fix),
wallet/topup/withdraw, tickets, notifications list, terminal/desktop
(no v1 endpoints — product decision needed: new v1 endpoints vs WebView).
