FROM ubuntu:14.04

#######################################################################################

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r freeswitch && useradd -r -g freeswitch freeswitch

# install basics
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install curl git

# install freeswitch
RUN echo 'deb http://files.freeswitch.org/repo/deb/debian/ wheezy main' >>/etc/apt/sources.list.d/freeswitch.list \
 && curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - 
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get  -y install freeswitch-meta-all


ENV PATH /usr/bin:$PATH
ENV FSCONF /etc/freeswitch

VOLUME ["/etc/freeswitch"]

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

# expose port
EXPOSE 5060

CMD ["freeswitch -c"]
#######################################################################################
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
