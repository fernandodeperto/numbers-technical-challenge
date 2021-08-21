#!/bin/bash
sudo -i
apt-get update
apt-get install -yq \
    libpq-dev \
    python3-dev \
    python3-pip \
    supervisor

git clone \
    --depth=1 \
    --branch ${branch} \
    https://github.com/fernandodeperto/numbers-technical-challenge.git \
    /magnusapi

cd /magnusapi/magnusapi

pip3 install -r requirements.txt

export FLASK_APP=magnusapi.api:app
export SQLALCHEMY_DATABASE_URI=postgresql://${postgresql_username}:${postgresql_password}@${postgresql_host}/magnusapi
flask db upgrade

cat << EOF > /etc/supervisor/conf.d/magnusapi.conf
[program:magnusapi]
command=/usr/local/bin/gunicorn --bind 0.0.0.0:8000 --log-config logging.ini magnusapi.api:app
process_name=%(program_name)s
directory=/magnusapi/magnusapi
environment=SECRET_KEY="${flask_secret_key}"
environment=SQLALCHEMY_DATABASE_URI="postgresql://${postgresql_username}:${postgresql_password}@${postgresql_host}/magnusapi"
EOF

systemctl restart supervisor
