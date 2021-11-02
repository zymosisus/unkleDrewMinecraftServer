# Volume-Manager
 This project is to facalitate the migration of data from the old VM to the new docker volume and develop the future volume initalization/restore, backup and other maintenance services(?). Gentoo was choosen as the base image because I like Gentoo, and SSH/SFTP was already installed in the base package. I know this is overkill and I will make this smaller at some point. 

## Where I'm at.
I can manually migrate files with the volume-manager.
Docker Secret works for SSH Key.

## To-Do
    
1. New Volume for backups.  
    Map to /var/games/minecraft/archives/{serverName} 
    Name: minecraft-data-archive
3. Scripts
    1. Backup Data - send to NAS
    2. Restore from backup
4. Research Services / cron jobs?
5. Minimize Container Size.
6. Cleanup Items
    1. volumemanager in the docker stack command? 
    2. Update run commands to add -rm to remove container upon shutdown. 
___


## Commands
- Build Command

    ```
    $ cd src/volume-manager/
    $ docker build -t gentoo-dev .
    ```
- Run container

    ```
    docker run `
    -v minecraft-data-{environment}:/var/games/minecraft/servers/unkledrew `
    -it gentoo-dev
    ```
    >Note: running the container bare will not allow you access secrets that are defined in the docker-compose.yml and accessed with the Docker Swarm.

- Docker Compose

    ```
    docker compose build
    ```

    ```
    docker compose up
    ```
    >Note: running the container bare will not allow you access secrets that added with the Docker Compose file/Swarm.

- Docker Swarm
    
    ```
    docker stack deploy --compose-file docker-compose.yml volumemanager
    ```

    Attach to bash shell on container with secrets. 
    ```
    docker exec -ti  $(docker ps --filter name=volumemanager_volumemanager -q) /bin/bash
    ```
    
    Shutdown
    ```
    docker service rm $(docker service ls --filter name=volumemanager_volumemanager -q)
    ```


## Secret creation

1. Create a SSH Key 
    In the ./home/.ssh directory in the project, run:
       
    ```
    cd ./home/.ssh
    ssh-keygen -t ed25519 -f ./id_ed25519 -C "minecraftdata@volumemanager"
    ```
    >Note: The public key needs to be added to the authorized_keys on the host.

2. Initalize a Docker Swarm. See: [Manage sensitive data with Docker secrets](https://docs.docker.com/engine/swarm/secrets/)
    ```
    docker swarm init
    ```
3. Add Docker Secret

    ```
    docker secret create ssh_id_ed25519_key id_ed25519
    ```
4. Deploy swarm & attach to shell
    ```
    docker stack deploy --compose-file docker-compose.yml 
    ```
    Find the volume name and attach
    ```
    docker ps
    ```
    ```
    docker exec -ti  $(docker ps --filter name=volumemanager_volumemanager -q) /bin/bash

    OR

    docker container exec $( docker container exec $(docker ps --filter name=volumemanager_volumemanager -q) /bin/bash -q) /bin/bash
    ```
---
### Personal Notes for my migration. (Delete before push?)
- Data migration.

    - Steps to run on the original MineOs VM
    1. Copy the files to a newly named directory.
    1. Tar the original server directory on the MineOS VM. 
        ```
        tar -czvf /var/games/minecraft/archive/Production/{servername}.{date}.tar.gz \
        -C /var/games/minecraft/servers Production.
        ```
    2. Copy the file to the NAS.
        ```
        scp /var/games/minecraft/archive/Production/{servername}.{date}.tar.gz `
        {user@host}:/share/Public/MinecraftBackups/
        ```
    ___

    - Steps to run on Volume-Manager container.
    1. Copy the file from the NAS
        ```
        scp {user@host}:/share/Public/MinecraftBackups/{servername}.{date}.tar.gz '
        /var/games/minecraft/servers/Production/
        ```
    
    2. Extract the image
        ```
        cd /var/games/minecraft/server/
        tar -xzvf {servername}.20211031.tar.gz -C /var/games/minecraft/servers/{servername}
        #clean up your artifacts, even if the container will kill it.
        rm {servername}.{date}.tar.gz
        ```
    3. Update Perms Plugin. 
