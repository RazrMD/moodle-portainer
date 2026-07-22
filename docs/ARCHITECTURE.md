# Architecture

The stack contains four services:

- `moodle`: PHP 8.3 Apache container with Moodle source code.
- `mariadb`: MariaDB 11.4 database.
- `redis`: Redis cache and Moodle session backend.
- `cron`: Moodle cron runner sharing the same application and data volumes.

Persistent volumes:

- `moodle_app`: Moodle application directory and generated `config.php`.
- `moodle_data`: Moodle dataroot.
- `moodle_db`: MariaDB database files.
- `redis_data`: Redis persistence.

Only Nginx Proxy Manager should expose Moodle publicly. The Moodle container joins the external `proxy` network so NPM can route traffic to it by service name.

Startup flow:

1. The image contains a fresh copy of Moodle in `/usr/src/moodle`.
2. On first container start, Moodle is copied into `moodle_app`.
3. `config.php` is generated from environment variables.
4. If the database is empty and `MOODLE_ADMIN_PASSWORD` is set, Moodle is installed from CLI.
5. On later redeploys, existing volumes are reused and installation is skipped.
