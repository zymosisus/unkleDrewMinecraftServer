# syntax=docker/dockerfile:1

#######################################
## Spigot Server and Multiverse Plugins.
#######################################
FROM maven:3.8.1-openjdk-16 as spigotBuilder

WORKDIR /src/spigot/build
RUN curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar \
    && cp ./spigot*.jar /src/spigot \
    && cd .. \
    && rm -rf build

WORKDIR /src/plugins
RUN mkdir out
# Get and build Multiverse-Core
RUN git clone https://github.com/Multiverse/Multiverse-Core
RUN cd Multiverse-Core \ 
    && mvn install \ 
    && cp ./target/Multiverse-Core-*-SNAPSHOT.jar /src/plugins/out/Multiverse-Core.jar \
    && cd .. \
    && rm -rf Multiverse-Core
# Get and build Multiverse-Portals
RUN git clone https://github.com/Multiverse/Multiverse-Portals
RUN cd Multiverse-Portals \
    && mvn install \
    && cp ./target/Multiverse-Portals-*-SNAPSHOT.jar /src/plugins/out/Multiverse-Portals.jar \
    && cd .. \
    && rm -rf Multivers-Portals
# Get Multiverse-Inbentories
RUN git clone https://github.com/Multiverse/Multiverse-Inventories
RUN cd Multiverse-Inventories \
    && mvn install \
    && cp ./target/Multiverse-Inventories-*-SNAPSHOT.jar /src/plugins/out/Multiverse-Inventories.jar \
    && cd .. \
    && rm -rf Multivers-Inventories


#######################################
# Gradle Plugin Builder
#######################################
FROM gradle:jdk16 as pluginBuilder

WORKDIR /src/plugins
RUN mkdir out

# Get and build LuckPerms
RUN git clone https://github.com/lucko/LuckPerms.git \
    && cd LuckPerms/ \
    && ./gradlew build \
    && cd .. \
    && cp LuckPerms/bukkit/loader/build/libs/LuckPerms-Bukkit-*.jar ./out/LuckPerms.jar \
    && rm -rf LuckPerms
# Get and build WorldEdit
RUN git clone https://github.com/EngineHub/WorldEdit \
    && cd WorldEdit/ \
    && ./gradlew build \
    && cp /src/plugins/WorldEdit/worldedit-bukkit/build/libs/worldedit-bukkit-*-SNAPSHOT-dist.jar /src/plugins/out/WorldEdit.jar \
    && cd .. \
    && rm -rf WorldEdit
# Get and build WorldGuard
RUN git clone https://github.com/EngineHub/worldguard \
    && cd worldguard/ \
    && ./gradlew build \
    && cd .. \
    && cp /src/plugins/worldguard/worldguard-bukkit/build/libs/*-SNAPSHOT-dist.jar /src/plugins/out/WorldGuard.jar \
    && rm -rf worldguard
# Get and build EssentialsX
RUN git clone https://github.com/EssentialsX/Essentials \
    && cd Essentials/ \
    && ./gradlew build \
    && cd .. \
    && cp /src/plugins/Essentials/jars/EssentialsX-*.jar /src/plugins/out/EssentialsX.jar \
    && rm -rf Essentials

#######################################
# Runtime Container
#######################################
FROM openjdk:16-jdk-buster

RUN apt-get install git

WORKDIR /var/games/minecraft/servers/unkledrew
COPY ./src /src

# Copy Server file.
RUN mkdir -p /src/spigot 
COPY --from=spigotBuilder /src/spigot/spigot*.jar /src/spigot/spigot.jar

#Copy Plugins
RUN mkdir /src/plugins
COPY --from=spigotBuilder /src/plugins/out/* /src/plugins/
COPY --from=pluginBuilder /src/plugins/out/* /src/plugins/

#Run the server.
CMD /src/scripts/startServer.sh