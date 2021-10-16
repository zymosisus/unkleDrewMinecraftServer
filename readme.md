# Info
## UnkleDrew's Minecraft Server

This is a Dockerized version of my minecraft server
- Downloads the Spigot Build tools and builds Spigot
- Clone Plugin Repos and build
- Copies Built Server Jar and Plugin files to the Server Data Volume 

### Avaliable Plugins
 - EssentialsX
 - WorldEdit
 - WorldGuard
 - LuckPerms
 - MultiVerse Core
 - Multiverse Portals
 - Multiverse Invetory

### Additional Plugins to add:
 - ModArena

# Building/Serving Server
## Requirements:
Beyond an internet connection, these are the items you need to run. 
- Docker (If you're using windows, WSL2 needs to be installed and running.)

## Setup

### EULA
Agree to the Minecraft Server EULA in /src/eula/eula.txt
```
eula=true
```

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
0. Clean up Docker File and Plugin build commands.
1. Environment info.
    - Need to design this. 
        - ServerName needs to be a variable that can change by environment. 
11. Add MobArena plugin to Build files.
2. Figure out how to keep config files updated (Server, Plugin files).
3. Version Manager for Plugins? 
3. Backup / Restore Scripts for Server Files.
    1. Pass Scerets to the container.
4. Server Manager (MineOS?)
5. startServer script
    1. Create Plugin folder if doesn't exist.

## Maybe Someday
1. MySql Server to configure LuckPerms/WorldGuard

    
