# Set up some environment variables as /etc/environment
# isn't sourced in chroot
set -x
set -e

export HOME=/root

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -yq nginx

cat > /etc/nginx/sites-available/default << EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;

    error_page 500 501 502 503 504 506 507 508 510 511 /jupyter_50x.html;
    location = /jupyter_50x.html {
        ssi on;
        root /usr/share/nginx/html;
        internal;
    }

    location / {
        proxy_set_header   X-Forwarded-For \$remote_addr;
        proxy_set_header   Host \$http_host;
        proxy_pass         "http://127.0.0.1:8080";

        # WebSocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_read_timeout 86400;

        proxy_buffering off;
    }
}
EOF

cat > /usr/share/nginx/jupyter_50x.html << EOF
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>JupyterLab</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        h1 {text-align: center;}
        p {text-align: center;}
        div {text-align: center;}
    </style>
    <!--# if expr="$status = 502" -->
      <meta http-equiv="refresh" content="5">
    <!--# endif -->
  </head>
<body>
  <!--# if expr="$status = 502" -->
    <h1>JupyterLab is starting</h1>
    <p>This may take a few minutes.</p>
  <!--# else -->
    <h1><!--# echo var="status" default="" --> <!--# echo var="status_text" default="Unknown error" -->
  <!--# endif -->
</body>
</html>
EOF
