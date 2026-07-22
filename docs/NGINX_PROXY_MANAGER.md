# Nginx Proxy Manager

Create a Proxy Host:

```text
Domain Names: moodle.curca.eu
Scheme: http
Forward Hostname / IP: moodle
Forward Port: 80
Cache Assets: off
Block Common Exploits: on
Websockets Support: on
```

SSL tab:

```text
SSL Certificate: Request a new SSL Certificate
Force SSL: on
HTTP/2 Support: on
HSTS Enabled: optional
```

Advanced tab for 2 GB uploads:

```nginx
client_max_body_size 2048m;
proxy_read_timeout 600s;
proxy_send_timeout 600s;
proxy_connect_timeout 600s;
```

Nginx Proxy Manager must be connected to the same external Docker network as the Moodle service. This repository expects that network to be named `proxy`.
