# Info
## Unkle TheDrew's Minecraft Server

This is a Dockerized version of my minecraft server with buildable Server & Plugins. 

## Avaliable Plugins
- EssentialsX
- WorldEdit
- WorldGuard
- LuckPerms

- MultiVerse Core
    - Multiverse Portals
    - Multiverse Invetory

Additional Plugins to add:
- ModArena
# Building/Serving Server
## Requirements:
Beyond an internet connection, these are the items you need to run. 
- Docker Desktop

## Setup
### Creating a Volume Drive:
(Need to add some information here about creating a volume?)
 
### Docker
- Build Command 
    
    Build the docker minecraft image 

    ```
    docker build -t minecraft .
    ```
- Run Container (powershell)

    ```
    docker run \
        -v e:\minecraftdata\server-dev:/var/games/minecraft/server/devServer \
        -p 25566:25565 -it minecraft
    ```
### Docker Compose
- Build and run in one.

    ```
    docker compose --env-file ./configs/.env up 
    ```

# ToDo
1. Environment info.
2. Docker Compose file. 
3. Proper Volumes
4. Setup Remote Version Control
4. git Version Control for
    1. DockerFile and Docker-Compose
    2. Run Scripts
    3. Config Files
5. Reconfigure Config Files.
6. Backup / Restore Scripts for Server Files.
7. Server Manager (MineOS?)

## Maybe Someday
1. MySql Server to configure LuckPerms/WorldGuard

    
