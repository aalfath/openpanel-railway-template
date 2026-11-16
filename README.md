# OpenPanel on Railway

Railway template for [OpenPanel](https://openpanel.dev), the open-source web and product analytics platform (events, funnels, retention, user profiles, real-time dashboards). This repo wraps the official OpenPanel images, pinned by version and digest, so every app service in the template builds from here.

**Version:** OpenPanel **2.3.0** (`lindesvard/openpanel-api`, `openpanel-dashboard`, `openpanel-worker`), ClickHouse 25.10.2.65, Caddy 2.11.9.

## What it deploys

| Service | Source | Role |
|---|---|---|
| `OpenPanel` | `proxy/` (Caddy) | The public domain. Routes `/api` to the API and everything else to the dashboard, like upstream's self-hosting Caddyfile. Health check `/proxy-health` |
| `OpenPanel API` | `api/` | Event ingestion, auth and tRPC. Runs the Postgres and ClickHouse migrations on every start, then starts. Health check `/healthcheck` |
| `OpenPanel Dashboard` | `dashboard/` | The web UI. Gets only public URLs, no database credentials. Health check `/api/healthcheck` |
| `OpenPanel Worker` | `worker/` | Queues, event batching and scheduled jobs. Health check `/healthcheck` |
| `ClickHouse` | `clickhouse/` | Event storage, password-protected, volume at `/var/lib/clickhouse`. Health check `/ping` |
| `Postgres` | Railway Postgres | Users, projects, dashboards |
| `Redis` | Railway Redis | Queues and cache |

## Variables

All variables are filled in by the template: generated secrets (`COOKIE_SECRET`, `CLICKHOUSE_PASSWORD`), references between services (`DATABASE_URL`, `REDIS_URL`, `CLICKHOUSE_URL`, `API_URL`, `DASHBOARD_URL`) and `PORT`. Nothing to type at deploy time.

Fixed settings live in the Dockerfiles and can be overridden with a service variable on `OpenPanel API` and `OpenPanel Worker`:

- `ALLOW_REGISTRATION=false`: only the first account can sign up. Invite teammates from the dashboard (`ALLOW_INVITATION=true`).
- `BATCH_SIZE=5000`, `BATCH_INTERVAL=10000`: event batching.

Optional features (set on `OpenPanel API` and `OpenPanel Worker`): email through `RESEND_API_KEY` and `EMAIL_SENDER`, the AI assistant through `OPENAI_API_KEY` or `ANTHROPIC_API_KEY`. See [OpenPanel's environment variables](https://openpanel.dev/docs/self-hosting/environment-variables).

## Custom domain

Add your domain to the `OpenPanel` service. Then, on `OpenPanel API`, set `API_URL` to `https://YOUR-DOMAIN/api`, `DASHBOARD_URL` to `https://YOUR-DOMAIN` and `CUSTOM_COOKIE_DOMAIN` to `YOUR-DOMAIN`. The worker and dashboard read these from the API service, so one change covers all three.

## Updates

Each service's `Dockerfile` pins its upstream image as `image:version@sha256:digest`. New versions land here as a pull request that bumps the pin and adds a `CHANGELOG.md` entry; once merged to `main`, Railway shows an "update available" notice to everyone who deployed the template, and you choose when to apply it. Read `CHANGELOG.md` first: breaking changes are listed at the top of each entry.

OpenPanel 3 (in development upstream) adds a required Redpanda (Kafka) service. It will arrive as a separate, clearly marked update once its images are published.

## License

The wrapper files in this repo are MIT. OpenPanel is AGPL-3.0, ClickHouse and Caddy are Apache-2.0.
