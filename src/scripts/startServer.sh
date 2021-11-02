#!/bin/bash
echo "Coping Server File to Mounted Volume"
cp /src/spigot/spigot.jar /var/games/minecraft/servers/unkledrew/spigot.jar

echo "Coping Plugins to Mounted Volume"
cp /src/plugins/EssentialsX.jar /var/games/minecraft/servers/unkledrew/plugins/Essentials.jar
cp /src/plugins/WorldEdit.jar /var/games/minecraft/servers/unkledrew/plugins/WorldEdit.jar
cp /src/plugins/WorldGuard.jar /var/games/minecraft/servers/unkledrew/plugins/WorldGuard.jar
cp /src/plugins/Multiverse-Core.jar /var/games/minecraft/servers/unkledrew/plugins/Multiverse-Core.jar
cp /src/plugins/Multiverse-Portals.jar /var/games/minecraft/servers/unkledrew/plugins/Multiverse-Portals.jar
cp /src/plugins/Multiverse-Inventories.jar /var/games/minecraft/servers/unkledrew/plugins/Multiverse-Inventories.jar
cp /src/plugins/LuckPerms.jar /var/games/minecraft/servers/unkledrew/plugins/LuckPerms.jar

echo "Get Config Files - source control for configuration management."
#git checkout master
 
echo ${PWD}
echo "Copy EULA"
cp /src/eula/eula.txt /var/games/minecraft/servers/unkledrew/eula.txt

echo "Start the server"
java -Xms2G -Xmx2g -jar spigot.jar --nogui