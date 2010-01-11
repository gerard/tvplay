#!/bin/sh

TVPLAY_XINITRC=$HOME/.tvplay.xinitrc
PLAYER=mplayer
OPTS="-fs"

# Prepend 2 backslashes to ' so it the escaping persists trought the bash
# escape removal.
VIDS=`echo "$*" | sed "s/'/\\\\\'/g"`

echo "xterm -e \"$PLAYER $OPTS $VIDS\"" > $TVPLAY_XINITRC
XINITRC=$TVPLAY_XINITRC xinit
rm $TVPLAY_XINITRC
