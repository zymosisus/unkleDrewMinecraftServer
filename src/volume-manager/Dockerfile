# syntax=docker/dockerfile:1

#######################################
## Volume Manager - Base Linux system to mount volume and have the tools necessary for
## initalizing a volume and populating the data.
#######################################
FROM gentoo/stage3:latest as dev

# Download git for development purposes.
RUN emerge --sync\
     && emerge --oneshot sys-apps/portage\
     && emerge dev-vcs/git\
     && emerge app-editors/vim

### Temporary This worked...
COPY ./home /root
RUN chmod 644 /root/.ssh/known_hosts

WORKDIR /var/games/minecraft/servers
CMD ["/bin/bash"]
