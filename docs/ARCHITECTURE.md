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
