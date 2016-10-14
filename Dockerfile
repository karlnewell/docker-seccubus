FROM ubuntu:14.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
 apache2 mysql-server ruby libalgorithm-diff-perl libjson-perl libxml-simple-perl libhtml-tree-perl libapache2-mod-perl2 wget \
 && rm -rf /var/lib/apt/lists/*

COPY apache2.seccubus /etc/apache2/sites-available/seccubus.working

RUN a2dissite 000-default && a2enmod perl && a2enmod cgid

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
CMD ["/bin/bash"]
