# GPG Profile
set -x GPG_TTY (tty)

# Start Sway at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
       	launch-sway
    end
end

### ALIASES ###

# root privileges
alias doas="doas --"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# vim and emacs
alias vim='nvim'

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing alias l.='exa -a | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# git to dot
alias config="/usr/bin/git --git-dir=$XDG_CONFIG_HOME/ --work-tree=$HOME"

# SSH-agent
setenv SSH_ENV $HOME/.ssh/environment
source $XDG_CONFIG_HOME/fish/functions/ssh_agent_start.fish

if [ -n "$SSH_AGENT_PID" ] 
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end  
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end  
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else 
        start_agent
    end  
end
#if test -z (pgrep ssh-agent)
#  eval (ssh-agent -c) > /dev/null
#  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
#  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
#end
