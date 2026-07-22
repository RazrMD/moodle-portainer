# Install

## Prerequisites

- Docker and Portainer
- Existing external Docker network named `proxy`
- Nginx Proxy Manager attached to the same `proxy` network
- DNS `A` record for `moodle.curca.eu` pointing to the server

## Portainer Git Stack

Use:

```text
Repository URL: https://github.com/RazrMD/moodle-portainer.git
Reference: main
Compose path: compose.yaml
```

Set environment variables from `.env.example` in the Portainer stack UI.

## First Run

For unattended installation, set:

```text
MOODLE_ADMIN_PASSWORD=<strong admin password>
```

Then deploy the stack. The entrypoint will:

1. Copy Moodle source into the persistent application volume.
2. Wait for MariaDB.
3. Generate `config.php`.
4. Install Moodle if the database is empty.
5. Configure the site timezone.

If `MOODLE_ADMIN_PASSWORD` is empty, use manual installation:

1. Open `https://moodle.curca.eu`.
2. Complete the Moodle installer.
3. Use database host `mariadb`.
4. Use the database name, user, and password from the stack environment.
5. Use dataroot `/var/moodledata`.

After installation, sign in with:

```text
Username: admin
Password: value of MOODLE_ADMIN_PASSWORD
```
