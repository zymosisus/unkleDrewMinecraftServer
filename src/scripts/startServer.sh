#!/bin/bash
echo "Coping Server File to Mounted Volume"
cp /src/spigot/spigot.jar /var/games/minecraft/server/devServer/spigot.jar

echo "Coping Plugins to Mounted Volume"
cp /src/plugins/EssentialsX.jar /var/games/minecraft/server/devServer/plugins/Essentials.jar
cp /src/plugins/WorldEdit.jar /var/games/minecraft/server/devServer/plugins/WorldEdit.jar
cp /src/plugins/WorldGuard.jar /var/games/minecraft/server/devServer/plugins/WorldGuard.jar
cp /src/plugins/Multiverse-Core.jar /var/games/minecraft/server/devServer/plugins/Multiverse-Core.jar
cp /src/plugins/Multiverse-Portals.jar /var/games/minecraft/server/devServer/plugins/Multiverse-Portals.jar
cp /src/plugins/Multiverse-Inventories.jar /var/games/minecraft/server/devServer/plugins/Multiverse-Inventories.jar
cp /src/plugins/LuckPerms.jar /var/games/minecraft/server/devServer/plugins/LuckPerms.jar

echo "Get Config Files"
#git clone https://github.com/zymosisus/minecraft-configs ./
#git checkout master
ls -la 
echo ${PWD}

echo "Start the server"
java -Xms2G -Xmx2g -jar spigot.jar --nogui