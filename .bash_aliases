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
alias guard='title GUARD ${PWD##*/}; bx guard && wait $!; title Console'

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
GIT_JOIN="\[\033[48;5;179m\033[38;5;30m\]"
GIT_BRANCH="\[\033[48;5;179m\033[38;5;17m\]"
GIT_CLEAN="\033[48;5;22m"
GIT_DIRTY="\033[48;5;88m"
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

# Set the title of gnome terminal
function title {
  echo -ne "\033]0;$*\007"
}

# Return the name of the root directory for the current repo
function repo_root {
  d=`pwd`
  while [ "$d" != "" ]; do
    [ -d "$d"/.git ] && echo ${d##*/}
    d=${d%/*}
  done
}

# Check branch status
function get_branch_status {
  if [[ $(git status | tail -n1) != "nothing to commit (working directory clean)" ]]; then
    echo -e "$GIT_DIRTY"
  else
    echo -e "$GIT_CLEAN"
  fi
}

# Set the prompt according to which repo the current dir is in - if any
function set_prompt {
  # Set the default prompt
  PS1="$PS1_TIME$PS1_PATH\w$PS1_MARKER"

  # ADD GIT LABELS
  # If git status errors then we are not in a git repo
  # or we do not have git installed so leave prompt as default
  if [[ -z $(git status 2> /dev/null) ]]; then
    return
  fi

  # set repo name to the root dir name
  repo_name=$(repo_root)

  # find the origin file name of remote repo
  remote_repo_file=$(git remote -v | grep origin | tail -1 | cut -f2 -d":" | cut -f1 -d" ")

  # If there is a remote origin use file name to get repo name
  if [[ -n $remote_repo_file ]]; then
    repo_name=$(basename $remote_repo_file) | cut -f1 -d"."
  fi

  # set the title of the terminal to the current repo name
  term_title=(${repo_name//_/ })
  echo -ne "\033]0;${term_title[@]^}\007"

  # Check if the working branch is clean #253
  #branch_status=$([[ $(git status | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*")
  branch_status=$(get_branch_status)

  # Get the name of the current branch
  current_branch=$(git branch --no-color | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")

  # Set prompt with GIT labels
  PS1="$PS1_TIME$GIT_LABEL \${repo_name} $GIT_JOIN▶$GIT_BRANCH \${current_branch} \${branch_status} $GIT_PATH\w$PS1_MARKER"
}

# Custom window dims & pos for Sublime and Console duo
# requires wmctrl cli window manager
function edit_mode {
  file=$*
  title "Initialising Edit Mode"; echo "Please wait while edit mode initialises..."; wmctrl -r :ACTIVE: -b add,maximized_horz; wmctrl -r :ACTIVE: -e 0,0,874,-1,150; title "Slime Console"; slime $file & disown; sleep 0.8; wmctrl -r Sublime -b remove,maximized_vert; wmctrl -r Sublime -b add,maximized_horz; wmctrl -r Sublime -e 0,0,0,-1,824
}
alias em='edit_mode'
alias floatme='wmctrl -r :ACTIVE: -b remove,maximized_horz;wmctrl -r :ACTIVE: -b remove,maximized_vert; wmctrl -r :ACTIVE: -e 0,150,150,600,400'

# Output chmod reference diagram and usage
function chmod_ref {
  echo "
        OWNER  GROUP   WORLD
        r w x  r w x   r w x 
        1 1 1  1 0 1   1 0 1 
          7      5       5  
          |______|_______|
                 |   
                755
  "
  
  echo "
 000  001  010  011  100  101  110  111
  0    1    2    3    4    5    6    7
  "

  chmod --help
}

# Chief function to call all / any custom functions
function prompt_command {
	check_user
  set_prompt
}

# Initialisation commands
PROMPT_COMMAND=prompt_command