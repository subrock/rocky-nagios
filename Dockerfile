FROM rocky:latest
LABEL maintainer="Karl Schroeder <karl@subrock.com>"

ARG HTPASSWD=YOURPASSWORD

# Pre-reqs
RUN yum install -y iputils nodejs npm which procps chkconfig openssl-devel gcc glibc glibc-common wget unzip httpd php gd gd-devel perl autoconf gettext automake && yum clean all -y
RUN mkdir -p /var/www/html
RUN mkdir -p /run/php-fpm
WORKDIR /tmp
RUN wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/master.tar.gz && \
    wget -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/master.tar.gz && \
    tar xzf nagioscore.tar.gz && \
    tar xzf nagios-plugins.tar.gz && \
    rm nagioscore.tar.gz && \
    rm nagios-plugins.tar.gz

# Core setup
WORKDIR /tmp/nagioscore-master
RUN useradd nagios && \
    usermod -a -G nagios apache && \
    ./configure && \
    make all && \
    make install && \
    make install-init && \
    chkconfig --add nagios && \
    chkconfig --level 2345 httpd on && \
    make install-commandmode && \
    make install-config && \
    make install-webconf

RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin $HTPASSWD

# Plugins setup
WORKDIR /tmp/nagios-plugins-master
RUN ./tools/setup && \
    ./configure && \
    make && \
    make install && \
    make install-root

# Finalize
WORKDIR /tmp
RUN rm -rf /tmp/nagioscore-master && \
    rm -rf /tmp/nagios-plugins-master

COPY startup.sh /startup.sh
#CMD bash -C 'sh /startup.sh';'bash'
ENTRYPOINT /startup.sh start && /bin/bash

#ENTRYPOINT ["tail"]
#CMD ["-f","/usr/local/nagios/var/nagios.log"]
