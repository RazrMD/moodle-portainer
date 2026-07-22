# Portainer

Create the stack from Git:

```text
Stacks -> Add stack -> Repository
```

Use the repository and compose path from `docs/INSTALL.md`.

Enable image build or rebuild when redeploying, so Portainer rebuilds the Moodle image from the Dockerfile.

The stack expects an external Docker network named `proxy`. If your Nginx Proxy Manager network has a different name, either rename it in `compose.yaml` or create a Docker external network named `proxy`.

Nginx Proxy Manager proxy host:

```text
Domain: moodle.curca.eu
Forward hostname: moodle
Forward port: 80
SSL: Let's Encrypt
Force SSL: enabled
```

For full reverse proxy settings, see `docs/NGINX_PROXY_MANAGER.md`.
