#!/bin/bash -x

FILES=$(ls *.lua)
BOT_DIR=$(pwd)
GAME_DIR="/home/elly/Games/steamapps/common/dota 2 beta/game/dota/scripts/vscripts/bots"

rm -f "$GAME_DIR/"*

cp *.lua "$GAME_DIR"
cp -R utility "$GAME_DIR"

#for FILE in $FILES
#do
#    ln -s "$BOT_DIR/$FILE" "$GAME_DIR/$FILE"
#done
