# Bush capital nginx configuration

`sudo vim /etc/nginx/sites-available/bush_capital`

In Nginx, files in sites-available don't actually do anything until they are "linked" to the sites-enabled folder.

```bash
# 1. Link your new config to enable it
sudo ln -s /etc/nginx/sites-available/bush_capital /etc/nginx/sites-enabled/

# 2. Unlink the default config so it stops interfering
sudo rm /etc/nginx/sites-enabled/default
```

Test the Nginx configuration for syntax errors:

```bash
sudo nginx -t
# restart nginx to apply changes
sudo systemctl restart nginx
```

> [!TIP]
> To add a blog on blog.bush.capital, you just create a new file in sites-available and link it.

## Troubleshooting

### Refused connection

```text
This site can’t be reached
bush.capital refused to connect.
Try:
• Checking the connection
• Checking the proxy and the firewall
ERR_CONNECTION_REFUSED
```

- check if nginx is running: `sudo systemctl status nginx`
- check if ufw is allowing traffic on ports 80 and 443: `sudo ufw status`
- check the nginx config to see if ssl is configured correctly: `sudo vim /etc/nginx/sites-available/bush_capital` (compare the following with the above)
- re-run certbot to fix any issues with SSL: `sudo certbot --nginx -d bush.capital -d www.bush.capital`
- final firewall check: `sudo ufw allow 'Nginx Full'`
- check nginx and restart: `sudo systemctl restart nginx`

```nginx
# 1. Redirect HTTP to HTTPS
server {
    listen 80;
    server_name bush.capital www.bush.capital;

    # Needed for Certbot verification challenges
    location /.well-known/acme-challenge/ {
        root /var/www/html;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}

# 2. Main HTTPS Server
server {
    listen 443 ssl;
    server_name bush.capital www.bush.capital;

    # SSL Certificates (Certbot will find these)
    ssl_certificate /etc/letsencrypt/live/bush.capital/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/bush.capital/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    # Django Static Files
    location /static/ {
        alias /var/www/bush_capital/src/staticfiles/;
    }

    # Proxy to Gunicorn
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Production checklist

- confirm DNS A records point to droplet IP for `bush.capital` and `www.bush.capital`
- validate nginx config syntax: `sudo nginx -t`
- reload nginx after changes: `sudo systemctl reload nginx`
- verify TLS cert status and renewals: `sudo certbot certificates`
- verify firewall allows web traffic: `sudo ufw allow 'Nginx Full'`
- test app health through nginx (not only localhost): `curl -I https://bush.capital`
