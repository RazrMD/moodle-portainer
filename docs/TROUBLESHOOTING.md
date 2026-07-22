# Troubleshooting

## Portainer says the proxy network does not exist

The stack expects an external Docker network named `proxy`.

Create it on the Docker host or change the network name in `compose.yaml` to match the network used by Nginx Proxy Manager.

## Moodle opens with HTTP links behind HTTPS

Check Nginx Proxy Manager:

- Force SSL is enabled.
- Forward host is `moodle`.
- Forward port is `80`.

The generated `config.php` sets:

```php
$CFG->reverseproxy = true;
$CFG->sslproxy = true;
```

## Unattended installation did not run

Check that `MOODLE_ADMIN_PASSWORD` was set before the first deploy.

If the database already contains Moodle tables, installation is skipped intentionally.

## Uploads larger than expected fail

The container is configured for 2 GB uploads. Also check Nginx Proxy Manager's advanced configuration and any upstream proxy limits.

For Nginx Proxy Manager, add this in the proxy host advanced tab if needed:

```nginx
client_max_body_size 2048m;
proxy_read_timeout 600s;
proxy_send_timeout 600s;
```

## Rebuild does not update Moodle code

Portainer must redeploy with image rebuild enabled.

The `moodle_app` volume keeps the application directory persistent. For normal patch updates, Moodle's upgrade process should run after the new image is deployed. Major upgrades require backups and the steps in `docs/UPDATE.md`.
