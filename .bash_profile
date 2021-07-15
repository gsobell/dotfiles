#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR='vim'
export GTK2_RC_FILES="$HOME/.config/gtkrc-2.0/config"
export BROWSER=/usr/bin/firefox
export TRUEBROWSER=/usr/bin/firefox
export READER=/usr/bin/zathura
export COLORTERM="truecolor"
export PAGER="less"
export TERMINAL=/usr/bin/urxvt
export TERM=xterm
export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvtd
