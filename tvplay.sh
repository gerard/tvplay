#!/bin/sh

TVPLAY_XINITRC=$HOME/.tvplay.xinitrc
TVPLAY_HISTORY=$HOME/.tvplay.history
PLAYER=mplayer
OPTS="-fs"

while getopts "lh" FLAG
do
    case $FLAG in
    l)
        less $TVPLAY_HISTORY
        exit 0
        break;;
    h)
        echo "Sorry, nothing is going to help you.  Here is the code instead:"
        cat $0
        exit 0
        break;;
    esac
done

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
    echo `date` "$1" >> $TVPLAY_HISTORY
    VIDS="$VIDS $TMPDIR/$COUNT.avi"
    shift
done

echo "xterm -e \"$PLAYER $OPTS $VIDS\"" > $TVPLAY_XINITRC
XINITRC=$TVPLAY_XINITRC xinit

# Now delete xinitrc and links
rm -r $TMPDIR
rm $TVPLAY_XINITRC
