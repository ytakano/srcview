FROM httpd:2.4

ARG TITLE="ARM Trusted Firmware"
ARG GIT=https://github.com/ARM-software/arm-trusted-firmware.git

RUN sed -i 's/deb\.debian\.org/ftp\.jaist\.ac\.jp\/pub\/Linux/g' /etc/apt/sources.list

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y tzdata

# timezone setting
ENV TZ=Asia/Tokyo

RUN apt-get -y install zsh git global

RUN cd /usr/local/apache2 && \
    rm -rf htdocs && \
    git clone --depth=1 $GIT htdocs && \
    cd htdocs && \
    gtags && \
    htags --suggest2 -t "$TITLE"

RUN sed -i 's/#LoadModule cgid_module modules/LoadModule cgid_module modules/g; \
            s/#AddHandler cgi-script/AddHandler cgi-script/g' \
           /usr/local/apache2/conf/httpd.conf

RUN echo \
'<Directory "/usr/local/apache2/htdocs/HTML/cgi-bin">\n\
    Options +ExecCGI\n\
    AddHandler cgi-script .cgi\n\
</Directory>' >> /usr/local/apache2/conf/httpd.conf

