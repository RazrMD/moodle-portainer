# Moodle Portainer

Production-ready Moodle deployment for Portainer.

## Stack
- Moodle 5.2
- MariaDB 11
- Redis
- Cron worker

## Files
- `compose.yaml`
- `Dockerfile`
- `php.ini`
- `.env.example`
- `.gitignore`
- `README.md`

## Deployment
1. In Portainer, go to **Stacks**.
2. Choose **Add stack**.
3. Select **Repository**.
4. Use this repository URL: `https://github.com/RazrMD/moodle-portainer`
5. Set the compose path to `compose.yaml`.
6. Deploy the stack.

## DNS
Point `moodle.curca.eu` to the server IP and configure a reverse proxy in Nginx Proxy Manager.

## Notes
- The first run creates the Moodle site automatically.
- Store `moodledata` and database files in persistent volumes.
