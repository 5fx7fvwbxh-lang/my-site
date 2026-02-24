#!/user/bin/env bash

USER="dobc"
PROJ_DIR="/var/www/bush_capital"
UV="/home/$USER/.local/bin/uv"
PY_MANAGE="src/manage.py"

ehco "Deploying for bush.capital..."

cd $PROJ_DIR

git pull origin main

$UV sync

echo "Collecting static files..."
if [ -f "$PY_MANAGE" ]; then
    $UV run python $PY_MANAGE collectstatic --no-input || echo "no static files to collect"
fi

sudo systemctl restart gunicorn

echo "Deployment done"
