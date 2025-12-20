#!/usr/bin/env bash

GAME_ID="1697700"
YOUR_HOME="/home/thomasgl"
YOUR_STEAM_DIR="$YOUR_HOME/.local/share/Steam"

compatdataDir="$YOUR_STEAM_DIR/steamapps/compatdata/${GAME_ID}"
mkdir "$compatdataDir" 2> /dev/null
winePrefixDir=${compatdataDir}/pfx

echo "Trying to enter winePrefixDir.."
cd "$winePrefixDir" || exit
echo "Entered winePrefixDir!"

export STEAM_COMPAT_DATA_PATH="$compatdataDir"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$YOUR_HOME/.steam"
export WINEPREFIX="${winePrefixDir}"

echo "Starting..."
"$YOUR_STEAM_DIR/compatibilitytools.d/GE-Proton10-16/proton" run "$YOUR_STEAM_DIR/steamapps/common/Who's Lila/DAEMON/DAEMON.exe"
