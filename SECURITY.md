# Security

Do not commit `.env` or any production passwords.

Recommended production settings:

- Use strong unique values for `MYSQL_PASSWORD`, `MYSQL_ROOT_PASSWORD`, and `MOODLE_ADMIN_PASSWORD`.
- Keep the repository public only if it contains no secrets.
- Terminate HTTPS in Nginx Proxy Manager with Let's Encrypt.
- Back up before every Moodle update.
- Restrict Portainer and Nginx Proxy Manager administration to trusted IPs or VPN where possible.

SMTP is intentionally disabled in the initial deployment and should be configured later inside Moodle or through a future environment-driven release.
