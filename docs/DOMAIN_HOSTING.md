# Domain to register + VPS to host

> After a night's search, I decided to buy from [Porkbun](https://porkbun.com/): bush.capital.
> Highlights:
>
> - First year promotion;
> - WHOIS to mask the owner's information;
> - SSL certificate for free;

## Domain name

`bush.capital` is perfect!

Default name servers:

- curitiba.ns.porkbun.com
- fortaleza.ns.porkbun.com
- maceio.ns.porkbun.com
- salvador.ns.porkbun.com

Will change to DigitalOcean name servers later:

- ns1.digitalocean.com
- ns2.digitalocean.com
- ns3.digitalocean.com

## VPS hosting

DigitalOcean is the choice!

Subscribed to a droplet with the following specs:

- CPU: 1 vCPU
- RAM: 512 MB
- Storage: 10 GB SSD
- Region: Sydney
- Price: $4/month
- IP: 1xx.6x.1xx.1xx
- Public key: `cat ~/.ssh/do_bush_capital_0226.pub`

```bash
# Allow SSH so you don't lock yourself out (port 22)
ufw allow OpenSSH

# Allow web traffic
ufw allow 80
ufw allow 443

# Enable the firewall
ufw enable
```

Add a non-root user:

```bash
adduser dobc
# password: short as before
usermod -aG sudo dobc
# copy ssh key from root to dobc
rsync --archive --chown=dobc:dobc ~/.ssh /home/dob
```

Now test the new user by logging in with `ssh dobc@1xx.6x.1xx.1xx` and check the firewall status:

```bash
dobc@ubuntu-s-1vcpu-512mb-10gb-syd1-01-bush-capital:~$ sudo ufw status
[sudo] password for dobc:
Status: active

To                         Action      From
--                         ------      ----
80                         ALLOW       Anywhere
443                        ALLOW       Anywhere
OpenSSH                    ALLOW       Anywhere
80 (v6)                    ALLOW       Anywhere (v6)
443 (v6)                   ALLOW       Anywhere (v6)
OpenSSH (v6)               ALLOW       Anywhere (v6)
```

Disable root login:

```bash
sudo vim /etc/ssh/sshd_config
# Change the line "PermitRootLogin prohibit-password" to "PermitRootLogin no"
sudo systemctl restart sshd
```

Create two A records to map Porkbun domain name to DigitalOcean droplet IP address in DigitalOcean:

```
Type: A
Hostname: @
Value: 1xx.6x.1xx.1xx
TTL: 3600
```

```
Type: A
Hostname: www
Value: 1xx.6x.1xx.1xx
TTL: 3600
```

How to check:
You can use a tool like [Google's Dig](https://toolbox.googleapps.com/apps/dig/) or [DNSChecker.org](https://dnschecker.org/). Type in domain and look for the Droplet's IP address. If it shows up, the link is live.

Or use the command line:

```bash
dig +short bush.capital
# or whois bush.capital
```

> [!TIP]
> | Task | Where to go |
> |------|------------|
> | Renewing the domain (paying the annual fee) | Porkbun |
> | Changing Nameservers (switching managers) | Porkbun |
> | Adding an A Record (pointing to your Droplet) | DigitalOcean |
> | Adding a CNAME (for www or subdomains) | DigitalOcean |
> | Adding MX Records (if you set up email later) | DigitalOcean |

It's on! Check `https://dnschecker.org/#NS/bush.capital`.

## Cerbot

Install Certbot:

```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx -y
```

```shell
> sudo certbot --nginx -d bush.capital -d www.bush.capital
[sudo] password for dobc:
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Enter email address (used for urgent renewal and security notices)
 (Enter 'c' to cancel): <digitalocean email address>

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.6-August-18-2025.pdf. You must agree
in order to register with the ACME server. Do you agree?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: y

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing, once your first certificate is successfully issued, to
share your email address with the Electronic Frontier Foundation, a founding
partner of the Let's Encrypt project and the non-profit organization that
develops Certbot? We'd like to send you email about our work encrypting the web,
EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: y
Account registered.
Requesting a certificate for bush.capital and www.bush.capital

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/bush.capital/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/bush.capital/privkey.pem
This certificate expires on 2026-05-24.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.

Deploying certificate
Successfully deployed certificate for bush.capital to /etc/nginx/sites-enabled/default
Successfully deployed certificate for www.bush.capital to /etc/nginx/sites-enabled/default
Congratulations! You have successfully enabled HTTPS on https://bush.capital and https://www.bush.capital

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

```

Testing the auto-renewal:

```bash
> sudo certbot renew --dry-run
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/bush.capital.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Account registered.
Simulating renewal of an existing certificate for bush.capital and www.bush.capital

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations, all simulated renewals succeeded:
  /etc/letsencrypt/live/bush.capital/fullchain.pem (success)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

```
