#
# ~/.bashrc
# _               _              
#| |__   __ _ ___| |__  _ __ ___ 
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__ 
#|_.__/ \__,_|___/_| |_|_|  \___|
#                                
#
[[ $- != *i* ]] && return

#set -o vi

# The sh .profile is softlinked to here.
# XDG Environmental Variables and Related Necessitated aliases
# and https://wiki.archlinux.org/index.php/XDG_Base_Directory_support

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR='vim'
export TERMINAL='kitty'
export READER='zathura'
export BROWSER='firefox'
export TRUEBROWSER='firefox'
export COLORTERM='truecolor'
export PAGER='less'
export GIT_PAGER='colordiff'

export SUDO_EDITOR="vim sudoedit"
export SUDO_PROMPT="$(tput setaf 1 bold)Password:$(tput sgr0) "

export ERRFILE="$HOME/.cache/X11/xsession-errors"
export HISTFILE="$XDG_DATA_HOME/bash/history"
export HISTORY_IGNORE="(ls|cd|pwd|exit|history|cd -|cd ..)"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
#export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-P -c"

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|sakura|alacritty|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac
use_color=true

# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions. Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.config/dir_colors   ]] && match_lhs="${match_lhs}$(<~/.config/dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if   [[ -f ~/.config/dir_colors ]] ; then
			eval "$(dircolors -b ~/.config/dir_colors)"
		elif [[ -f /etc/DIR_COLORS ]]      ; then
			eval "$(dircolors -b /etc/DIR_COLORS)"
		fi
	fi


	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;34m\][\u@\h\[\033[01;37m\] \W\[\033[01;34m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto -h --group-directories-first'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vim/vimrc'
alias snips='vim ~/.vim/UltiSnips/tex.snippets'
alias gitrc='vim ~/.config/git/config'
alias helixrc='helix ~/.config/helix/config.toml'
alias dunstrc='vim ~/.config/dunst/dunstrc'
alias newsrc='vim -p ~/.config/newsboat/urls ~/.config/newsboat/config'
alias dmenurc='vim ~/.config/dmenu-recent/config'
alias i3rc='vim ~/.config/i3/config'
alias i3b='vim ~/.config/i3blocks/config'
alias ala='vim ~/.config/alacritty/alacritty.toml'
alias kit='vim ~/.config/kitty/kitty.conf'

alias u='taskell ~/Notes/u.md'
alias v='vim'
alias p='python'
alias r="ranger"
alias sr='sudo ranger'
alias h='helix'
alias hx='helix'

alias cr='cd ~/Documents/Repos; ls'
alias diff='colordiff'
alias df='df -h'
alias ll='ls -la' 
alias lsa='ls -a'
alias cp='cp -i'
alias n='cd ~/Notes'
alias mkdir='mkdir -pv'
alias py='bpython'

alias j='journalctl'
alias jg='journalctl -g --boot=-1'    #grep last boot
alias jf='journalctl -f'              #follow journal
alias je='journalctl -b --priority=3' #errors
alias jb='journalctl -b'              #current boot

alias neo='neofetch'
alias mutt='neomutt'
alias news='newsboat'
alias rss='newsboat'
alias www='curl wttr.in/Jerusalem'
alias ww='curl v2.wttr.in/Jerusalem'
alias zmanim='hebcal -tZEC Jerusalem'
alias sunset='zmanim | grep "Sunset"'
alias rainy=' mpv https://rainyday.radio.mynoise.net/ & rain'
alias wiki="wikicurses"
alias heb='trans :he'
alias ttyc='tty-clock -cC 4'
alias pipes='pipes.sh -p 5'
alias tetris='tint'
alias please='sudo'
alias yay='paru'

#alias p='playerctl play-pause'
#alias b='playerctl previous'
#alias n='playerctl next'

alias :q='exit'
alias :q!='shutdown now'
alias :l='clear'
alias :w='fortune'
alias ZZ='blurlock && systemctl suspend'

# The following are the X11 specific aliases

alias xx='xrdb ~/.config/X11/Xresources'
alias X='vim ~/.config/X11/Xresources'

alias yy='xclip'    # see wl-clipboard 
alias pp='xclip -o'

xhost +local:root > /dev/null 2>&1

complete -cf sudo
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s autocd
shopt -s cdspell
shopt -s histappend

ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

source /usr/share/doc/pkgfile/command-not-found.bash
#command_not_found_handle() {
#      if [[ $1 =~ .*.md  ]]; then vim "$1"
#    elif [[ $1 =~ .*.csv ]]; then sc-im "$1"
#    elif [[ $1 =~ .*.pdf ]]; then zathura "$1" & disown
#    elif [[ $1 =~ .*.jpg ]]||[[ $1 =~ .*.png ]]; then exec feh "$1" & disown
#    echo "Command not found"
#    fi
#}


t (){
if [[ -e "todo.md" ]]; then
    taskell todo.md
elif [[ -e "TODO.md" ]]; then
    taskell TODO.md
else
     taskell ~/Notes/todo.md
fi
}

#Prints a list of installed packages

packlist() {
	pacman -Qet -q > ~/.config/packlist/"$HOSTNAME-$(date +%F)"
        /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/.config/packlist/"$HOSTNAME-$(date +%F)"
	pacman -Qet -q > ~/.config/packlist/"$HOSTNAME"
	/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/.config/packlist/"$HOSTNAME"
}

present() {
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T && echo "Present mode is:" && xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -v

}

pan() {
       pandoc -r markdown -w pdf -o $1.pdf $1.md	
}

rpan(){
        echo "Utility for converting online news articles to PDF"
        read -p "Filename: " FILE
        read -p "URL: " URL
        curl $URL       |
        readable --low-confidence force --base |
        pandoc -f html -t ~/"$FILE".pdf --pdf-engine=xelatex
}

recent() {
	find $HOME -maxdepth 1 -type l | xargs rm 2> /dev/null
	i=1; find $HOME/Notes -type f -name "*.md" -printf '%TY-%Tm-%Td %TT %p\n' | sort | tail -n 5  | cut -c 32- | while read f;do ln -sf "$f" $HOME/; ((i++));done
}

nw() {
        set "$(cd ~/Notes ; ls -d */ )";
        select subject in "${@%/}";
        do 
	read -p "Note title: " title;
        echo "# $title $subject $(date +%d-%m-%C)" > ~/Notes/$subject/$(date +%d-%m-%C).md
        vim ~/Notes/$subject/$(date +%d-%m-%C).md  
	break; done;

}

wpc(){
        sudo
        cp $1 /usr/share/backgrounds/"$1"
        lightdm-gtk-greeter-settings 
}

ns() {
        cd $HOME/Notes; git add -A
	if [[ -n "$1" ]]
	then git commit -S -m "$1"
 	else git commit -S -m "$HOSTNAME $(date +%X)"
	fi
	git push
	cd -
}

np() {
        git -C ~/Notes pull
}

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

dots() {
        /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add -u
				# if [[ -n "$1" ]]
				# then /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m "$1"
				# else /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m "$HOSTNAME $(date +%X)"
				# fi
				/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit
				/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push 
}

uusb(){
        sync  /run/media/$USER/* || notify-send "No mounted device" 
        umount /run/media/$USER/* &&
        notify-send "All Unmounted"
}

alias usb='/run/media/$USER/* || /run/media/$USER ; ls'


z(){
        zathura $1 &
        disown
}


rmgen(){
        folder_name=$(basename "$(pwd)")
        vim -c "normal gg" -c "normal i# ${folder_name}" -c "normal o" -c "startinsert" README.md
        # vim -c 'startinsert' README.md #generated read me in WD
}
[ -f ~/.xsession-errors ] && rm ~/.xsession-errors

tex_open() {
    while true; do
    local files=(*.tex)
    local selected=0
    local num_files=${#files[@]}
    if [ $num_files -eq 0 ]; then
        echo "No .tex files found in the current directory." # this never runs, fix later
        return 1
    fi

    while true; do
        clear
        echo "Select a .tex file using arrow keys:"
        local display=()
        for ((i=0; i<$num_files; i++)); do
            if [ $i -eq $selected ]; then
                display+=("> $((i+1)). ${files[i]}")
            else
                display+=("  $((i+1)). ${files[i]}")
            fi
        done
        printf "%s\n" "${display[@]}"
        read -rsn1 key
        case $key in
            "A") # up
                ((selected--))
                if [ $selected -lt 0 ]; then
                    selected=$((num_files - 1))
                fi
                ;;
            "B") # down
                ((selected++))
                if [ $selected -ge $num_files ]; then
                    selected=0
                fi
                ;;
            "") # enter
                vim ${files[selected]}
                echo "You selected: ${files[selected]}"
                return 0
                ;;
        "q" | "Q") # exit
                    return 0
                    ;;
        esac
    done
done
}
alias :o='tex_open'
# EOF
