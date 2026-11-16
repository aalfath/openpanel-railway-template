# Changelog

## 2026-11-16: OpenPanel 2.3.0 (first release)

- OpenPanel 2.3.0 API, dashboard and worker, ClickHouse 25.10.2.65, Caddy 2.11.9, each pinned by digest.
- One public domain through Caddy (`/api` to the API, the rest to the dashboard).
- Migrations run on every API start, with retries while the databases come up.
- ClickHouse is password-protected; the dashboard gets no database credentials.
