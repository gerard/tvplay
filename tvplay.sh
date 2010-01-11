#!/bin/sh

TVPLAY_XINITRC=$HOME/.tvplay.xinitrc
PLAYER=mplayer
OPTS="-fs"

echo "xterm -e \"$PLAYER $OPTS '$*'\"" > $TVPLAY_XINITRC
XINITRC=$TVPLAY_XINITRC xinit
rm $TVPLAY_XINITRC
