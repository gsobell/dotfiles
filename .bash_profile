#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Export Default MIME Programs

export EDITOR='vim'
export TERMINAL=/usr/bin/urxvt
export READER=/usr/bin/zathura
export BROWSER=/usr/bin/firefox
export TRUEBROWSER=/usr/bin/firefox
export COLORTERM="truecolor"
export PAGER="less"

# Frameworks

export QT_QPA_PLATFORMTHEME="qt5ct"
export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvtd
export CARGO_HOME="$XDG_DATA_HOME"/cargo # Rust package manager .cargo
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
eval $(dircolors "$XDG_CONFIG_HOME"/dir_colors)

#export GTK2_RC_FILES="$HOME/.config/gtkrc-2.0/config"

# Pretty colors, now for less

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESSHISTFILE="-"

[ -f ~/.xsession-errors ] && rm ~/.xsession-errors

