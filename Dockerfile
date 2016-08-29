FROM fabioluciano/docker-s3fs
MAINTAINER Fábio Luciano <fabioluciano@php.net>
LABEL Description="Monta um drive do S3"

ENV USER usuario
ENV PASSWORD senha

COPY files/* /etc/

RUN apk update \
  && apk --update --no-cache add samba \
  && rm -rf /var/cache/apk/* \
  && addgroup -g 1000 ${USER} \
  && adduser -D -H -G ${USER} -s /bin/false -u 1000 ${USER} \
  && echo -e "letsdance\nletsdance" | smbpasswd -a -s -c /etc/smb.conf ${USER}

VOLUME /mnt

EXPOSE 137/udp 138/udp 139 445
