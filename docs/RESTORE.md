# Restore

Restoring replaces the database and `moodledata` contents. Back up the current state before restoring.

From Portainer, open the `moodle` container console and run:

```bash
moodle-restore /backups/YYYYMMDDTHHMMSSZ
```

After restore, restart the stack from Portainer.
