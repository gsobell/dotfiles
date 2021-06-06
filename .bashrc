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
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
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

alias i3='vim ~/.i3/config'
alias i3status='vim ~/.config/i3status/config'
alias bash='vim ~/.bashrc'
alias X='vim .Xresources'
alias td='vim ~/to.do.md'
alias vimrc='vim ~/.vimrc'
alias gitrc='vim ~/.gitconfig'
alias muttrc='vim ~/.config/mutt/muttrc'
alias newsrc='vim -p ~/.newsboat/urls ~/.newsboat/config'
alias cp='cp -i'
alias i='i3-swallow'
alias diff='colordiff'
alias df='df -h'
alias ll='ls -la' 
alias lsa='ls -a'
alias yy='xclip'
alias xx='xrdb ~/.Xresources'
alias pp='xclip -o'
alias v='vim'
alias r="ranger"
alias sr='sudo ranger'
alias sranger='sudo ranger'
alias news='newsboat'
alias nacp='cd $HOME/Notes; git acp; cd -'
alias mkdir='mkdir -pv'
alias yay='paru'
alias free='free -m' 
alias ttyc='tty-clock -cC 4'
alias pipes='pipes.sh'
alias neo='neofetch'
alias mutt='neomutt'
alias ww='curl wttr.in'
alias heb='trans :he'
alias please='sudo'
alias doas='sudo'
alias p='playerctl play-pause'
alias b='playerctl previous'
alias n='playerctl next'
alias :q='exit'
alias :q!='shutdown now'
alias :l='clear'
alias tetris='tint'
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# alias tetris='mpv --no-video https://www.youtube.com/watch?v=9Fv5cuYZFC0 & disown && tint'

#git aliases

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s autocd
shopt -s cdspell
# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
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

#Automagically opens markdown files in vim

command_not_found_handle() {
      if [[ $1 =~ .*.md  ]]; then vim "$1"
    elif [[ $1 =~ .*.csv ]]; then sc-im "$1"
    elif [[ $1 =~ .*.pdf ]]; then zathura "$1"
    elif [[ $1 =~ .*.jpg ]]||[[ $1 =~ .*.png ]]; then viewnior "$1"
    else echo "Command not found"
    fi
}

#Prints a list of installed packages

packlist() 
{
	pacman -Qet -q > "Packages-$(date +%F).txt"
}

present() {
	
	xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -T&& echo "Present mode is:" && xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -v

}

rdng() {

	readable $1 | w3m -T text/html
	#readable $1 | lynx -stdin
}

pan() {
       pandoc -r markdown -w pdf -o $1.pdf $1.md	
}

recent() {
	
find $HOME -maxdepth 1 -type l | xargs rm 2> /dev/null
i=1; find $HOME/Notes -type f -name "*.md" -printf '%TY-%Tm-%Td %TT %p\n' | sort | tail -n 5  | cut -c 32- | while read f;do ln -sf $f $HOME/; ((i++));done

}

nn() {
read -p "Optional title, enter to continue: " Title;
select CLASS in Math Physics Hebrew;
do vim $HOME/Notes/$CLASS/"$CLASS-$(date +%x).md"
break; done;

}


recent
