#!/bin/bash
sudo -i
apt-get update
apt-get install -yq \
    python3-pip \
    supervisor

git clone \
    --depth=1 \
    --branch ${branch} \
    https://github.com/fernandodeperto/numbers-technical-challenge.git \
    /magnusapi

pip3 install \
    -r /magnusapi/magnusapi/requirements.txt

cat << EOF > /etc/supervisor/conf.d/magnusapi.conf
[program:magnusapi]
command=/usr/local/bin/uvicorn magnusapi.api:app --host 0.0.0.0
process_name=%(program_name)s
directory=/magnusapi/magnusapi
EOF

systemctl restart supervisor
