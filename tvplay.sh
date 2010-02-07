#!/bin/sh

TVPLAY_XINITRC=$HOME/.tvplay.xinitrc
PLAYER=mplayer
OPTS="-fs"

# Since using filenames with special characters is a PITA, we just link the
# the file instead using a symbolic link.  That way we don't have to deal with
# special characters when writing the xinitrc file.
# Links will be called 1.avi, 2.avi and so on
TMPDIR=`mktemp -d /tmp/tvplay.XXXXXXXX`
COUNT=0
while [ -n "$1" ]
do
    COUNT=`expr $COUNT + 1`
    ln -s "$1"  $TMPDIR/$COUNT.avi
    echo `date` "$1" >> ~/.tvplay.history
    VIDS="$VIDS $TMPDIR/$COUNT.avi"
    shift
done

echo "xterm -e \"$PLAYER $OPTS $VIDS\"" > $TVPLAY_XINITRC
XINITRC=$TVPLAY_XINITRC xinit

# Now delete xinitrc and links
rm -r $TMPDIR
rm $TVPLAY_XINITRC
