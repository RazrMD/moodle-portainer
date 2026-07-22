# Moodle Portainer

Production-oriented Moodle stack for Portainer and Nginx Proxy Manager.

Target deployment:

- Moodle from the official `moodle/moodle` source repository
- Moodle branch `MOODLE_520_STABLE`
- PHP 8.3 with Apache
- MariaDB 11.4
- Redis 7
- Docker volumes for persistent data
- `moodle.curca.eu` behind Nginx Proxy Manager
- Upload limit: 2 GB
- Server profile: 4 GB RAM

## Status

`v0.1` provides the foundation:

- Docker image build
- Portainer-compatible `compose.yaml`
- PHP and Apache baseline configuration
- MariaDB and Redis services
- Separate cron container
- Environment template
- Deployment documentation

Automatic Moodle installation and first-run provisioning will be added in `v0.2`.

## Quick Start

1. In Portainer, open `Stacks` -> `Add stack`.
2. Select `Repository`.
3. Use repository URL:

   ```text
   https://github.com/RazrMD/moodle-portainer.git
   ```

4. Set reference to:

   ```text
   main
   ```

5. Set compose path to:

   ```text
   compose.yaml
   ```

6. Configure environment variables from `.env.example`.
7. Deploy the stack.

Then configure Nginx Proxy Manager:

- Domain: `moodle.curca.eu`
- Forward hostname: `moodle`
- Forward port: `80`
- Enable SSL with Let's Encrypt
- Enable Force SSL

## Data Persistence

The stack uses Docker volumes:

- `moodle_app` for Moodle application files and generated `config.php`
- `moodle_data` for uploaded files and course data
- `moodle_db` for MariaDB data
- `redis_data` for Redis data

Do not delete these volumes unless you intend to remove the LMS data.

## Updates

For patch updates on the same Moodle stable branch, use Portainer `Redeploy` with image rebuild enabled. Data remains in Docker volumes.

Major Moodle upgrades require reading `docs/UPDATE.md` first.
