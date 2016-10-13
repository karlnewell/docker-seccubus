FROM ubuntu:14.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
 apache2 mysql-server ruby libalgorithm-diff-perl libjson-perl libxml-simple-perl libhtml-tree-perl libapache2-mod-perl2 wget \
 && rm -rf /var/lib/apt/lists/*

#RUN wget \
#    https://github.com/schubergphilis/Seccubus_v2/releases/download/2.26/seccubus_2.26.1_amd64.deb && \
#    dpkg --force-all -i seccubus_2.26.1_amd64.deb

COPY apache2.seccubus /etc/apache2/sites-available/seccubus.working

RUN a2dissite 000-default && a2enmod perl && a2enmod cgid

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80
CMD ["/bin/bash"]
