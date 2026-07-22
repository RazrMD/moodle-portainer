# Backup

The image includes `moodle-backup`.

From Portainer:

1. Open the `moodle` container.
2. Open `Console`.
3. Run:

   ```bash
   moodle-backup
   ```

The script creates:

- `database.sql.gz`
- `moodledata.tar.gz`
- `moodle-app.tar.gz`

Backups are stored under:

```text
backups/YYYYMMDDTHHMMSSZ/
```

Retention is controlled by:

```text
BACKUP_RETENTION_DAYS=14
```
