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

`v0.1` prepares the infrastructure and generates `config.php`. Moodle web installation is still manual:

1. Open `https://moodle.curca.eu`.
2. Complete the Moodle installer.
3. Use database host `mariadb`.
4. Use the database name, user, and password from the stack environment.
5. Use dataroot `/var/moodledata`.

Automatic installation is planned for `v0.2`.
