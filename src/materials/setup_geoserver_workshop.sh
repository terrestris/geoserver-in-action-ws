#!/bin/bash

HOME_DIR=~
USER_NAME=user
USER_GROUP=user
WORKSHOP_DOWNLOAD_BASE_URL=https://raw.githubusercontent.com/terrestris/geoserver-in-action-ws/master/src/materials
GEOSERVER_VERSION=2.15.1
M2_FILES_URL=$WORKSHOP_DOWNLOAD_BASE_URL/local_maven_repo.tar.gz
INSPIRE_SRC_URL=$WORKSHOP_DOWNLOAD_BASE_URL/inspire_extension_source.tar.gz
GEOSERVER_LIB_DIR=/usr/local/lib/geoserver-$GEOSERVER_VERSION/webapps/geoserver/WEB-INF/lib
INSPIRE_JAR=gs-inspire-$GEOSERVER_VERSION.jar

# Remove the INSPIRE extension that is preinstalled on OSGeoLive from geoserver
echo -e "\nUninstalling the INSPIRE plugin (that is preinstalled on OSGeoLive) from the geoserver."
echo -e "We will later compile the sources ourselfes and install it again.\n"
rm $GEOSERVER_LIB_DIR/$INSPIRE_JAR

# Download and unpack the M2 repo files
echo -e "\nDownloading needed Maven repository files and unpacking them to $HOME_DIR/.m2\n"
curl $M2_FILES_URL | tar xz -C $HOME_DIR

# Set the owner
chown $USER_NAME:$USER_GROUP -R $HOME_DIR/.m2/

# Download and unpack the inspire src files
echo -e "\nDownloading needed sources of the GeoServer INSPIRE extension and unpacking them to $HOME_DIR/inspire_extension_source\n"
curl $INSPIRE_SRC_URL | tar xz -C $HOME_DIR

# Set the owner
chown $USER_NAME:$USER_GROUP -R $HOME_DIR/src/

# Update package list
echo -e "\nUpdating package lists...\n"
apt-get update

# Install Maven
echo -e "\nInstalling maven now...\n"
apt-get -y install maven
