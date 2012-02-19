# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# system tasks
alias ea='slime ~/.bash_aliases &'
alias reset='source ~/.bashrc; reset'
alias new-launcher='gnome-desktop-item-edit ~/Desktop/ --create-new'

# development tasks
alias g="git"
alias b='bundle'
alias bx='b exec'
alias rs='bx rspec'

# search functions
alias findme='grep -nir --exclude=\*.svn\* --exclude=\*.swp'
alias whouses='grep -lir --exclude=\*.svn\* --exclude=\*.swp'
alias findfile='find . -iname'
alias inspect='du -csh'

# applications
alias chrome='google-chrome'
alias windows='virtualbox --startvm "Win7 64bit CS5" --fullscreen &'

# package management
alias apt-update-with-keys='sudo apt-get update 2> /tmp/keymissing; for key in $(grep "NO_PUBKEY" /tmp/keymissing |sed "s/.*NO_PUBKEY //"); do echo -e "\nProcessing key: $key"; sudo gpg --keyserver subkeys.pgp.net --recv $key && sudo gpg --export --armor $key | sudo apt-key add -; done'


#------------------------------------------------------
# CUSTOM COMMAND PROMPT
#------------------------------------------------------

# COLOUR VARIABLES ------------------------------------
FG_BLACK="\[\033[0;30m\]"
FG_RED="\[\033[0;31m\]"
FG_GREEN="\[\033[0;32m\]"
FG_YELLOW="\[\033[0;33m\]"
FG_BLUE="\[\033[0;34m\]"
FG_PURPLE="\[\033[0;35m\]"
FG_TEAL="\[\033[0;36m\]"
FG_WHITE="\[\033[0;37m\]"
NO_COLOUR="\[\033[0m\]"

PS1_TIME="\[\033[48;5;17m\033[38;5;12m\]"
PS1_PATH="\[\033[0;38;5;12m\]"
PS1_MARKER="$FG_YELLOW\$$NO_COLOUR "
GIT_LABEL="\[\033[48;5;30m\033[38;5;17m\]"
GIT_BRANCH="\[\033[48;5;179m\033[38;5;17m\]"
GIT_PATH=$FG_TEAL
SVN_LABEL="\[\033[48;5;97m\033[38;5;17m\]"
SVN_PATH="\[\033[0;38;5;183m\]"
SVN_SPACER="\[\033[48;5;250m\]"


function check_user {
  # if user is not root
  if [[ $EUID -ne 0 ]]; then
    PS1_TIME="\[\033[48;5;17m\033[38;5;12m\] \$(date +%H:%M) "
    PS1_PATH="\[\033[0;38;5;12m\]"
    PS1_MARKER="$FG_YELLOW\$$NO_COLOUR "
  else
    PS1_TIME="\[\033[48;5;52m\033[38;5;161m\] \$(date +%H:%M) \[\033[48;5;88m\033[38;5;17m\] \$(id -nu) "
    PS1_PATH="\[\033[0;38;5;124m\]"
    PS1_MARKER="$FG_YELLOW#$NO_COLOUR "
  fi
}

# Output all available colour codes 
# Used to create new colour variables
function colours {
  for i in {0..255}; do echo -e "\e[38;05;${i}m${i}"; done | column -c 80 -s '  '; echo -e "\e[m"
}

# Check if the current git repo has uncommitted assets
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
  #" ☠ " <- Interesting skull icon from an online example
}

# Establish which branch is active in the current git repo
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Global variable holding the name/type of the current repo (eg. git or svn)
# =none if current dir is not a repo
current_repo=none

# Check to see if the current directory is a known version control repository
# If it is - set the global variable current_repo to the name/type of the repo
function which_repo {
  current_repo=none
  repos=( git svn )
  for r in "${repos[@]}"; do 
  	d=`pwd`
  	while [ "$d" != "" ]; do
	    [ -d "$d"/.$r ] && current_repo=$r
	    d=${d%/*}
	  done
	done
}

# Set the prompt according to which repo the current dir is in - if any
function set_prompt {
  which_repo
  case $current_repo in
    svn)
      PS1="$PS1_TIME$SVN_LABEL ${current_repo^^} $SVN_PATH\w$PS1_MARKER"
      ;; 
    git)
      PS1="$PS1_TIME$GIT_LABEL ${current_repo^^} $GIT_BRANCH \$(parse_git_branch) $GIT_PATH\w$PS1_MARKER"
      ;;
    none)
      PS1="$PS1_TIME$PS1_PATH\w$PS1_MARKER"
      ;;
  esac
}

# Set the title of gnome terminal
function title {
  echo -ne "\033]0;$*\007"
}

# Custom window dims & pos for Sublime and Console duo
# requires wmctrl cli window manager
function em {
  slime & disown; gnome-terminal --title "AutoConsolas"; sleep 0.3; wmctrl -r "AutoConsolas" -b add,maximized_horz; wmctrl -r "AutoConsolas" -e 0,0,874,-1,150; sleep 0.3; wmctrl -r Sublime -b remove,maximized_vert; wmctrl -r Sublime -b add,maximized_horz; wmctrl -r Sublime -e 0,0,0,-1,824; exit
}

# Chief function to call all / any custom functions
function prompt_command {
	check_user
  set_prompt
}
PROMPT_COMMAND=prompt_command
