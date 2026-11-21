# Rahul Mart backend + CRM (phase 2)

## What this package contains
- Preserved uploaded storefront `index.html` at `public/index.html` and `original-frontend/index.html` byte-for-byte (SHA-256: `f71eb30255b9d173ecd8ac3fcfdd3c79e1392452fd7b2f3d3bb3df6e7fbca4b0`).
- Express API with SQLite persistence and migrations for the starter database.
- Admin login with bcrypt password hash, JWT in HttpOnly cookie, CSRF token, strict SameSite cookie, login limiter, global rate limiter, Helmet CSP, and server-side validation.
- Admin CRM at `/admin`: dashboard, product add/edit/hide/delete, order status changes, customer list, and editable website/landing/SEO/social settings.
- Public catalog endpoint `GET /api/public/products` (active, in-stock products only).
- Public order endpoint `POST /api/public/orders` creates Cash-on-Delivery orders only. It calculates totals from server product prices, checks inventory inside a database transaction, and decreases stock atomically. There is no online-payment provider or card-data endpoint.
- Public settings endpoint `GET /api/public/settings` exposes store/contact/SEO/landing settings only.

## Important unfinished integration
The uploaded storefront remains unchanged, as requested. This means the existing customer-facing HTML has not yet been connected to the catalog API, COD order API, or dynamic landing-page settings. The API and CRM are available, but the storefront will not submit live COD orders until this integration and browser regression testing are completed. Do not deploy or represent this package as a complete production e-commerce site yet.

## Run locally
1. Use Node.js 20+.
2. Copy `.env.example` to `.env`.
3. Generate a secret with `node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"` and set it as `JWT_SECRET`.
4. Set `ADMIN_USERNAME` and a long unique `ADMIN_PASSWORD` in `.env` (never share or commit it).
5. Run `npm install`.
6. Run `npm start`.
7. Storefront URL: `http://localhost:3000/`; admin: `http://localhost:3000/admin`.


## API endpoints
- `POST /api/admin/login`, `POST /api/admin/logout`, `GET /api/admin/me`
- `GET /api/admin/dashboard`
- `GET/POST /api/admin/products`, `PUT/DELETE /api/admin/products/:id`
- `GET /api/admin/orders`, `PATCH /api/admin/orders/:id/status`
- `GET /api/admin/customers`
- `GET/PUT /api/admin/settings`
- `GET /api/public/products`, `GET /api/public/settings`, `POST /api/public/orders`

## Production hardening before launch
- Install and test dependencies; exercise login/API and order flow in a staging environment.
- Serve behind HTTPS; set `NODE_ENV=production`; configure secure cookies and a reverse proxy.
- Configure firewall, backups with restore test, logging/monitoring, DB permissions, and non-root service user.
- Add data-retention policy, privacy notice, and appropriate consent/controls for customer data.
- Add automated tests and independent security review. Security is improved but no system can be promised hack-proof.
- SEO indexing requires a live public domain, production meta tags/sitemap/robots and Google Search Console setup; backend settings alone do not make Google index the website.


## Windows Node 26 / no native-build install
This revision removes the native `better-sqlite3` dependency and uses Node's built-in `node:sqlite` API (Node 22.13+; Node 26 recommended). This avoids the Python/node-gyp error shown on Windows. The first run still downloads regular JavaScript dependencies through npm and requires an internet connection. Set `ADMIN_USERNAME`, a strong `ADMIN_PASSWORD`, and a random `JWT_SECRET` in `.env` before login. This package is a local starter and is not production-hardened or deployed.


## Admin login reset (for Invalid credentials)
Close the server window. Double-click RESET_ADMIN_AND_START.bat. It creates a new .env credential and starts the server; the database admin password is synchronized from that .env at startup. Save the new password displayed once. Do not share it.
