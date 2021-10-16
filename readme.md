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

### EULA
Agree to the Minecraft Server EULA in /src/eula

### Creating a Volume Drive:
(Need to add some information here about creating a volume?)
 
### Docker
- Build Command 
    
    Build the docker minecraft image 

    ```
    docker build -t minecraft .
    ```
- Run Container (powershell)

    ### To-Do: Update volume here. 

    ```
    docker run `
    -v minecraft-dev_minecraft-data:/var/games/minecraft/server/unkledrew `
    -p 25566:25565 -it minecraft
    ```
### Docker Compose
- Build and run in one.

    ```
    docker compose up 
    ```

# ToDo
1. Environment info.
    - Need to design this.  Shouldn't have to build twice. 
        - ServerName needs to be a variable that can change by environment. 
2. ~~Docker Compose file.~~ WORKING. Additional changes will be dev work.
3. Proper Volumes
    - Status: Copied E: over to wsl volume. 
    - Need to remove named binding over to "Volume" 
    - Need to create Dev Server initialization script.
4. Setup Remote Version Control
5. Reconfigure Config Files.
6. Backup / Restore Scripts for Server Files.
7. Server Manager (MineOS?)

## Maybe Someday
1. MySql Server to configure LuckPerms/WorldGuard

    
