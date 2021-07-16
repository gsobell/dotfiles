#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# The sh .profile is softlinked to here.
# XDG Environmental Variables and Related Necessitated aliases
# and https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ERRFILE="$HOME/.cache/X11/xsession-errors"

# Export Default MIME Programs

export EDITOR='vim'
export TERMINAL=/usr/bin/urxvt
export READER=/usr/bin/zathura
export BROWSER=/usr/bin/firefox
export TRUEBROWSER=/usr/bin/firefox
export COLORTERM="truecolor"
export PAGER="less"
export TERM=xterm

# Frameworks
export QT_QPA_PLATFORMTHEME="qt5ct"
export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvtd
export GTK2_RC_FILES="$HOME/.config/gtkrc-2.0/config"
export CARGO_HOME="$XDG_DATA_HOME"/cargo # Rust package manager .cargo
export HISTFILE="$XDG_DATA_HOME"/bash/history
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

eval $(dircolors "$XDG_CONFIG_HOME"/dir_colors)
alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc'

# Pretty colors, now for less

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESSHISTFILE=-
