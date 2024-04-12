#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.config/X11/Xresources
usermodmap=$HOME/.config/X11/Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

#USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
#USERXSESSIONRC="$XDG_CACHE_HOME/X11/xsessionrc"
#ALTUSERXSESSION="$XDG_CACHE_HOME/X11/Xsession"
#ERRFILE="/home/gabriel/.cache/X11/xsession-errors"

# merge in defaults and keymaps

#if [ -f $sysresources ]; then
#    xrdb -merge $sysresources
#fi

#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

unclutter -grab &
xbindkeys -f "$XDG_CONFIG_HOME"/xbindkeys/config &

export WINIT_X11_SCALE_FACTOR=1
xset r rate 660 25

exec i3 --shmlog-size 0
