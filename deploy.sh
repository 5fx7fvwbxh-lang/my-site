#!/user/bin/env bash

USER="dobc"
PROJ_DIR="/var/www/bush-capital"
UV="/home/$USER/.local/bin/uv"
PY_MANAGE="src/manage.py"

echo "Deploying for bush.capital..."

cd $PROJ_DIR

git pull origin main

$UV sync

echo "Collecting static files..."
if [ -f "$PY_MANAGE" ]; then
    $UV run python $PY_MANAGE collectstatic --noinput || echo "no static files to collect"
fi

sudo systemctl restart gunicorn

echo "Deployment done"
