FROM debian:bullseye-slim
# MAINTAINER simpit GmbH <info@simpit.ch>

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
# RUN apt-get update && \
    # apt-get install -y --no-install-recommends \
    # ca-certificates \
    # curl
    # dirmngr \
    # fonts-noto-cjk \
    # gnupg \
    # libssl-dev \
    # node-less \
    # npm \
    # python3-num2words \
    # python3-pdfminer \
    # python3-pip \
    # python3-phonenumbers \
    # python3-pyldap \
    # python3-qrcode \
    # python3-renderpm \
    # python3-setuptools \
    # python3-slugify \
    # python3-vobject \
    # python3-watchdog \
    # python3-xlrd \
    # python3-xlwt \
    # xz-utils \
    # && curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb \
    # && echo 'ea8277df4297afc507c61122f3c349af142f31e5 wkhtmltox.deb' | sha1sum -c - \
    # && apt-get install -y --no-install-recommends ./wkhtmltox.deb \
    # && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# install latest postgresql-client
# RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
#     && GNUPGHOME="$(mktemp -d)" \
#     && export GNUPGHOME \
#     && repokey='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8' \
#     && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${repokey}" \
#     && gpg --batch --armor --export "${repokey}" > /etc/apt/trusted.gpg.d/pgdg.gpg.asc \
#     && gpgconf --kill all \
#     && rm -rf "$GNUPGHOME" \
#     && apt-get update  \
#     && apt-get install --no-install-recommends -y postgresql-client \
#     && rm -f /etc/apt/sources.list.d/pgdg.list \
#     && rm -rf /var/lib/apt/lists/*

# Install rtlcss (on Debian buster)
# RUN npm install -g rtlcss

# Copy entrypoint script and Odoo configuration file
# COPY ./config/entrypoint.sh /
# COPY ./config/odoo.conf /etc/odoo/

## Set permissions and Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
#RUN chown odoo /etc/odoo/odoo.conf \
#    && mkdir -p /mnt/extra-addons \
#    && chown -R odoo /mnt/extra-addons
# RUN mkdir -p /var/log/odoo
# VOLUME ["/var/lib/odoo", "/var/log/odoo"]

# Expose Odoo services
EXPOSE 8069 8071 8072 22

# Set the default config file
# ENV ODOO_RC /etc/odoo/odoo.conf

# COPY config/wait-for-psql.py /usr/local/bin/wait-for-psql.py

USER root
# RUN apt-get update
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
# RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
# RUN locale-gen en_US.UTF-8
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US:en
# RUN update-locale LANG=en_US.UTF-8
# RUN dpkg-reconfigure --frontend=noninteractive locales
# RUN apt-get install unzip
# RUN apt-get --no-install-recommends -y install libreoffice
# RUN pip3 install --upgrade pip
# RUN pip3 install wheel
# RUN pip3 install click-odoo
# RUN pip3 install click-odoo-contrib
# RUN pip3 install py3o.template
# RUN pip3 install py3o.formats
# RUN pip3 install paramiko
# RUN pip3 install setuptools wheel
# RUN pip3 install web_pdb
# RUN pip3 install mysql-connector-python
# RUN pip3 install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib
# RUN pip3 install instagram-basic-display
# RUN pip3 install simplejson
#RUN apt-get --no-install-recommends -y install openssh-server
#RUN apt-get --no-install-recommends -y install logrotate
#RUN apt-get --no-install-recommends -y install cron
#RUN apt-get --no-install-recommends -y install gawk
#RUN apt-get --no-install-recommends -y install file
#RUN apt-get --no-install-recommends -y install iptables-persistent
RUN mkdir -p /var/lib/simpodoo/
RUN mkdir -p /var/lib/odoo/
RUN mkdir -p /var/lib/odoo/backups
# RUN apt-get install -y --allow-downgrades postgresql-client-common=225
# RUN apt-get install -f -y  logrotate postgresql postgresql-contrib
# set up odoo logrotate
# COPY config/odoo-logrotate /etc/logrotate.d/odoo
# RUN apt-get install -y python3 python-dev python3-dev\
    # build-essential libssl-dev libffi-dev \
    # libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev \
    # libldap2-dev
# RUN pip3 install psycopg2-binary

# ENTERPRISE MODULE DEPENDENCIES
# RUN pip3 install num2words ofxparse
# RUN apt-get install nodejs npm
# RUN npm install -g less
# RUN npm install -g less-plugin-clean-css


WORKDIR /var/lib/simpodoo/
# COPY . .
# RUN pip3 install -r requirements.txt
# RUN apt-get install -y zip
# RUN apt-get install -y wget ca-certificates
# RUN apt-get install -y lsb-release && apt-get clean all
# RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
# RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN apt-get update
RUN apt-get install -y ssh
RUN apt-get install -y nano
# RUN mkdir -p /root/.ssh
# COPY authorized_keys /root/.ssh/authorized_keys
# RUN pip3 install pdfforms
# RUN pip3 install reportlab

# RUN apt-get install -y cups
# RUN apt-get install -y libcups2-dev
# RUN apt-get install -y python3-dev
# RUN pip3 install pycups
# RUN pip3 install dicttoxml
# RUN pip3 install pandas
# RUN pip3 install odoorpc
# RUN pip3 install openpyxl
# RUN python3 -m pip install --upgrade pip
# RUN ln -s /usr/bin/pip /usr/bin/pip3.9
# RUN apt-get install -y git
# RUN pip3 install openai
# RUN pip3 install pulp
# RUN pip3 install html2text
# RUN pip3 install pdf2image
# RUN apt-get install -y poppler-utils
# RUN pip3 install opencv-python-headless
# RUN pip3 install PyMuPDF Pillow
# RUN apt-get install -y libzbar0
# RUN pip3 install pyzbar
# RUN pip3 install zxing
# RUN apt-get install -y default-jre
# RUN pip3 install mako
# RUN pip3 install pydevd-odoo
# RUN pip3 install langchain
# RUN pip3 install tiktoken
# RUN pip3 install clickhouse-connect
# RUN pip3 install xmltodict/
# ABOVE python 3.9 (we are running 3.9.2) odoo expects gevent 21.8.0. for some reason the requirements.txt file
# does not recognize the python version to be higher than 3.9 and installs an old version of gevent
# we fix it here by installing the correct version manually
# RUN pip3 install gevent==21.8.0
# RUN pip3 install simple-crypt==4.1.7

ENTRYPOINT ["tail", "-f", "/dev/null"]
