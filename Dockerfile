FROM phusion/baseimage:0.9.16

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
#######################################################################################

# install freeswitch
RUN echo 'deb http://files.freeswitch.org/repo/deb/debian/ wheezy main' >>/etc/apt/sources.list.d/freeswitch.list \
 && curl http://files.freeswitch.org/repo/deb/debian/freeswitch_archive_g0.pub | apt-key add - 
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get  -y install freeswitch-meta-all 

# setup service script
RUN mkdir /etc/service/freeswitch
ADD freeswitch.sh /etc/service/freeswitch/run
RUN chmod +x /etc/service/freeswitch/run

# setup init script
ADD freeswitch_setup.sh /etc/my_init.d/freeswitch_setup.sh
RUN chmod +x /etc/my_init.d/freeswitch_setup.sh


# define volume mount
VOLUME ["/etc/freeswitch"]

# expose port
EXPOSE 5060


#######################################################################################
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
