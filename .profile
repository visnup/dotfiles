export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/npm/bin:$PATH

# shared bash history
export CLICOLOR=1
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE
shopt -s cdspell histappend nocaseglob

# program args
export LESS='--RAW-CONTROL-CHARS --ignore-case --line-numbers --no-init'
export ACK_PAGER=less
export GREP_OPTIONS=--color

# vi 4eva
export EDITOR=vim
export VISUAL=vim

# node
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node_modules

# ruby
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
  export BUNDLER_EDITOR=mvim
fi

# prompt
. $HOME/Play/gists/prompt/termwide.sh

# z
. `brew --prefix`/etc/profile.d/z.sh

# bash completion
. /usr/local/etc/bash_completion.d/git-completion.bash
. /usr/local/etc/bash_completion.d/hub.bash_completion.sh

# aliases
alias ll='ls -lh'
alias git='hub'
alias gti='git'
alias cd.='cd $(git root)'
