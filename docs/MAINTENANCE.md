# Maintenance

## Regular Checks

Weekly:

- Check Portainer container status.
- Check available disk space.
- Run `moodle-backup`.
- Review Moodle admin notifications.

Monthly:

- Redeploy with image rebuild enabled to pull Moodle branch patch updates.
- Check `docs/UPDATE.md` before any major Moodle branch change.
- Confirm backups can be listed and copied off-server.

## Useful Portainer Console Commands

Run Moodle cron manually:

```bash
php /var/www/html/admin/cli/cron.php
```

Create a backup:

```bash
moodle-backup
```

Check Moodle version:

```bash
php /var/www/html/admin/cli/cfg.php --name=release
```

Purge Moodle caches:

```bash
php /var/www/html/admin/cli/purge_caches.php
```
