# Changelog

## v0.1.0 - Foundation

- Add Portainer-compatible Docker Compose stack.
- Add custom Moodle image built from official Moodle source.
- Add baseline PHP, Apache, Redis, and cron configuration.
- Add environment template and deployment documentation.

## 0.4.0 - Production project baseline

- Add unattended first-run installation when `MOODLE_ADMIN_PASSWORD` is set.
- Add healthcheck, backup, and restore helper scripts.
- Document backup, restore, and Portainer deployment flow.
- Add GitHub Actions validation workflow.
- Add operational troubleshooting and security notes.
- Add maintenance, Nginx Proxy Manager, and roadmap documentation.

## Unreleased

- Change Moodle healthcheck to avoid direct HTTP access when reverse proxy mode is enabled.
