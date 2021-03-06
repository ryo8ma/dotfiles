#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Author:   @da8ma <ryo.8mada1020@gmail.com>			   #
#------------------------------------------------------------------#

# --------------------------------------------------
#  zplugin
# --------------------------------------------------

### Added by Zplugin's installer
source $HOME/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Prompt theme
zinit load denysdovhan/spaceship-prompt

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma.github.io/zinit/wiki/For-Syntax/
zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word

### End of Zplugin's installer chunk

# --------------------------------------------------
#  general
# --------------------------------------------------

autoload -Uz colors
colors

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# --------------------------------------------------
#  command config
# --------------------------------------------------

# set aliases

if [ "$(uname)" = Darwin ]; then
    alias ls='ls -FG'
    alias ll='ls -FGal'
elif [ "$(uname)" = Linux ]; then
    alias ls='ls --color=auto -sCF'
fi

alias gip='curl ipinfo.io/ip'
alias getpass='openssl rand -base64 10'
alias check='brew upgrade'
alias d='docker'
alias dc='docker-compose'
alias drmi='docker rmi'
#alias docker-jupyter='docker run --rm -p 8888:8888 -v "$PWD":/home/jovyan/work jupyter/datascience-notebook'
alias be='bundle exec'
alias bundle='bundle _1.16.2_'

## Custom iTerm2 titlebar background colors
#echo -e "\033]6;1;bg;red;brightness;40\a"
#echo -e "\033]6;1;bg;green;brightness;44\a"
#echo -e "\033]6;1;bg;blue;brightness;52\a"

## Path

# gnu-sed
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

# for rbenv
if which rbenv >/dev/null; then
  eval "$(rbenv init -)"
  export PATH=$HOME/.rbenv/bin:$PATH
fi

# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script, which must be sourced
# in your shell's init script (ie, .bash_profile, .zshrc, whatever), will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.

# enable Yubikey authentification for the SSH client
export GPG_TTY=$(tty)
gpg-connect-agent /bye 2>/dev/null
gpg-connect-agent updatestartuptty /bye 2>/dev/null
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Add the following to your shell init to set up gpg-agent automatically for every shell
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
  . "$HOME"/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
fi

# google cloud sdk activate
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
