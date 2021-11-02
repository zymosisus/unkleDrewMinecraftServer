# Gentoo Development Container.
 A new Dockerfile was created to manage the migration of data from the old VM to the new docker volume and develop the future volume initalization, backups, and other maintenance services(?). Gentoo was choosen as the base image because I like Gentoo, and SSH/SFTP was already installed in the base package. I know this is overkill and I will make this smaller at some point. 

## Where I'm at.
I can manually migrate files with the volume-manager. 

## To-Do
    
1. Secrets - I need this to be able to connect with NAS through SSH single signon to automate backup & restore scripts. Right now I'm trying to get the hang of ssh keys for secure copy, these files have been added to to the .gitignore, but this is still ***bad*** practice. I'll fix it...just need to do more research.
2. New Volume for backups.  
    Map to /var/games/minecraft/archives/{serverName} 
    Name: minecraft-data-archive
3. Scripts
___


## Build and Server
- Build Command

    ```
    $ cd src/volume-manager/
    $ docker build -t gentoo-dev .
    ```
- Run container 
    
    ```
    docker run `
    -v minecraft-dev_minecraft-data-{environment}:/var/games/minecraft/servers/unkledrew `
    -it gentoo-dev
    ```

- Data migration.

    - Steps to run on the original MineOs VM
    1. Copy the files to a newly named 
    1. Tar the original server directory on the MineOS VM. 
        ```
        tar -czvf /var/games/minecraft/archive/Production/unkledrew.{date}.tar.gz \
        -C /var/games/minecraft/servers Production.
        ```
    2. Copy the file to the NAS.
        ```
        scp /var/games/minecraft/archive/Production/unkledrew.{date}.tar.gz `
        {user@host}:/share/Public/MinecraftBackups/
        ```
    ___

    - Steps to run on Volume-Manager container.
    1. Copy the file from the NAS
        ```
        scp {user@host}:/share/Public/MinecraftBackups/unkledrew.{date}.tar.gz '
        /var/games/minecraft/servers/Production/
        ```
        **TO-DO**
        1. Change Permissions on SSH keys.
    2. Extract the image
        ```
        cd /var/games/minecraft/server/
        tar -xzvf unkledrew.20211031.tar.gz -C /var/games/minecraft/servers/unkledrew
        #clean up your artifacts, even if the container will kill it.
        rm {servername}.{date}.tar.gz
        ```

## Secret creation
1. in the ./home/.ssh directory in the project, run:
       
    ```
    cd ./home/.ssh
    ssh-keygen -t ed25519 -f ./id_ed25519 -C "unkledrew@container"
    ```
    >The public key needs to be copied and added to the authorized_keys on the host.

2. I had to initalize a swarm...don't know about this yet...more research...[Manage sensitive data with Docker secrets](https://docs.docker.com/engine/swarm/secrets/)
    ```
    docker swarm init
    ```
3. Add Docker Secret

    ```
    docker secret create ssh_id_ed25519_key id_ed25519
    ```
4. Create Redis service to serve the key:
    ```
    docker service create `
        --name redis `
        --secret source=ssh_id_ed25519_key,target=/root/home/.ssh `
    redis:alpine
    ```


