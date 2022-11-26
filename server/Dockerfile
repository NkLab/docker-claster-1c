 FROM debian:10-slim
 LABEL maintainer="Nikolay Shukshin <ns@niko-lab.ru>"

ARG ONEC_BIT="64"
ARG ONEC_VERSION
ARG TYPE_SETUP="full"
ENV ONEC_ARCH="x86_64"

ENV onec_uid="999"
ENV onec_gid="999"
ENV gosu_ver=1.11
ENV nls_enabled=false
ENV nls=$nls_enabled
ENV ENV_ONEC_VERSION="$ONEC_VERSION"


SHELL ["/bin/bash", "-c"]
RUN if [ "$ONEC_BIT" = "32" ]; then $ONEC_ARCH="i386"; fi

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      locales \
      imagemagick \
      fontconfig \
      libgtk-3-0  \
      libenchant1c2a \
      libharfbuzz-icu0 \
      libgstreamer1.0-0 \
      libgstreamer-plugins-base1.0-0 \
      gstreamer1.0-plugins-good \
      gstreamer1.0-plugins-bad \
      libsecret-1-0 \
      libsoup2.4-1 \
      libsqlite3-0 \
      libegl1-mesa \
      libxrender1 \
      libxfixes3 \
      libxslt1.1 \
      geoclue-2.0 \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/debconf \
  && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.UTF-8

# ADD  http://ftp.ru.debian.org/debian/pool/main/e/enchant/libenchant1c2a_1.6.0-11.1+b1_amd64.deb .
# RUN  dpkg -i libenchant1c2a_1.6.0-11.1+b1_amd64.deb
COPY ./distr/ /tmp/
WORKDIR /tmp

RUN tar -xf "./server${ONEC_BIT}_${ONEC_VERSION//./_}.tar.gz" \
 && ./setup-${TYPE_SETUP}-${ONEC_VERSION}-${ONEC_ARCH}.run --mode unattended \
 --enable-components server,ru

RUN mkdir -p /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf \
   && chown -R usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8 
  #  && usermod -aG sudo usr1cv8

VOLUME /home/usr1cv8/.1cv8/ /var/log/1C

COPY ./server/logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf
COPY ./server/docker-entrypoint.sh /usr/local/bin
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 1540 1541
EXPOSE 1560-1591

CMD ["ragent"]
# ADD https://github.com/tianon/gosu/releases/download/$gosu_ver/gosu-amd64 /bin/gosu

# RUN chmod +x /bin/gosu

# FROM debian:bullseye-slim
# LABEL maintainer="Nikolay Shukshin <ns@niko-lab.ru>"
# ARG onec_uid="999"
# ARG onec_gid="999"


# COPY --from=base /opt /opt
# COPY --from=base /bin/gosu /bin/gosu

# RUN set -xe \
#   && apt-get update \
#   && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
#       locales \
#       imagemagick \
#       fontconfig \
#   && rm -rf \
#     /var/lib/apt/lists/* \
#     /var/cache/debconf \
#   && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
# ENV LANG ru_RU.UTF-8

# RUN groupadd -r grp1cv8 --gid=$onec_gid \
#   && useradd -r -g grp1cv8 --uid=$onec_uid --home-dir=/home/usr1cv8 --shell=/bin/bash usr1cv8 \
#   && mkdir -p /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf \
#   && chown -R usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8

# VOLUME /home/usr1cv8/.1cv8/ /var/log/1C

# COPY ./server/logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf

# # COPY ./server/docker-entrypoint.sh /usr/local/bin
# # RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat

# # ENTRYPOINT ["docker-entrypoint.sh"]

# EXPOSE 1540 1541
# EXPOSE 1560-1591