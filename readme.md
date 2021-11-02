# UnkleDrew's Minecraft Server
## Info

I started this project to Dockerize my Minecraft server. My previous server was hosted on a MineOS image running in a VirtualBox VM. Maintenance become too much as I was using out of date plugins, and building new versions of both the Spigot Server and the plugings and testing them became problematic.  CI/CD, Docker looked like interesting tools to migrate to. **This project should not be considered complete in any way :)**

(Add information about enviornments)

- Downloads the Spigot Build tools and builds the Spigot.jar server file.
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

(Add information about portability - Should be able to download)

- DockerDesktop 
    > The insturctions and information below assumes heavily that you're using this on a Windows machine with WSL2 installed and you're using PowerShell.
- Development Enviornment. May I suggest Visual Studio Code... 

## Setup

### EULA
Agree to the Minecraft Server EULA in /src/eula/eula.txt.
```
eula=true
```

### Creating a Volume Drive:
The Running host will require a persistent storage volume to store the server data. The instructions below will create a docker volume to maintain the data. See [docker docs: Use volumes]([https://docs.docker.com/storage/volumes/]) for more information. 

**Steps** 
1. Create a Docker Volume to hold the Minecraft Data for test environment. 
    ```
    docker volume create minecraft-data-test
    ```

    (Add information for "New Servers here")

    OPTIONAL: In my case I was migrating from an already existing world backup, and I wanted a way to easily restore from back up for testing/production purposes. In order to populate the volume I created another container to help facilitate with populating volumes with data from a current backup. See [volume-manager/readme.md](.\src\volume-manager\readme.md) for more information.
       
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
    -v minecraft-dev_minecraft-data:/var/games/minecraft/servers/unkledrew `
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
        - Test/Production volumes. (InProcess with volume-manager)
11. Add MobArena plugin to Build files.
12. Modify to use swarm so backup services can run too?
2. Figure out how to keep config files updated (Server, Plugin files).
3. Version/Package Manager for Plugins? 
3. Backup / Restore Scripts for Server Files. (Move this to the volume-manager.)
    1. Pass Scerets to the container.
4. Server Manager (MineOS?)
5. startServer script
    1. Create Plugin folder if doesn't exist.

## Maybe Someday
1. MySql Server to configure LuckPerms/WorldGuard

    
