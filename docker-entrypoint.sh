#!/bin/bash
set -e

SECVER=2.26
SECDEB=seccubus_2.26.1_amd64.deb
DBVER=8

service apache2 start

if [ ! -f "/seccubus_2.26.1_amd64.deb" ]; then #check whether seccubus is already installed
    wget https://github.com/schubergphilis/Seccubus_v2/releases/download/${SECVER}/${SECDEB} 
    dpkg --force-all -i ${SECDEB}

    cp /etc/apache2/sites-available/seccubus.working /etc/apache2/sites-available/seccubus.conf
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then #check whether the DB is initialized.
    echo 'Initializing database'
    mysql_install_db
    echo 'Database initialized'

    service mysql start

    /usr/bin/mysql -u root << EOF
    create database seccubus;
    grant all privileges on seccubus.* to seccubus@localhost identified by 'seccubus';
    flush privileges;
EOF

    /usr/bin/mysql -u seccubus -pseccubus seccubus < /var/lib/seccubus/structure_v${DBVER}.mysql
    /usr/bin/mysql -u seccubus -pseccubus seccubus < /var/lib/seccubus/data_v${DBVER}.mysql
fi

service mysql restart
service apache2 restart

exec "$@"
