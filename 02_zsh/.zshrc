# Use modern completion system
autoload -Uz compinit
compinit

# prompt theme system for changing prompt easily
# source: $ man zshroadmap
autoload -U promptinit
promptinit

# vcs_info will show if current directory is a local repo and the active branch name
autoload -Uz vcs_info
precmd() {
  psvar[1]=$(expressvpn status | grep -q Not && echo 'VPN:Off' || echo 'VPN:On')
  # Load version control information
  vcs_info
}

setopt PROMPT_SUBST
RPROMPT='%1v[%*]'
PROMPT='%F{green}%n%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f%(!.#.$) '

# working with history
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS INC_APPEND_HISTORY SHARE_HISTORY


# Preferred editor for local and remote sessions -- pjp
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='code'
else
  export EDITOR='vim.tiny'
fi

# Suffix aliases -- pjp
alias -s pdf=xreader
alias -s txt=vim
alias -s json=code
alias -s py=code
alias -s {html, cs, js, ts}=code

# Vi key bindings in insert mode
# Esc for command mode then usual navigation vi commands will work
bindkey -v
# so far it looks as if this works well, if not
# OR
# use zsh-vi-mode from https://github.com/jeffreytse/zsh-vi-mode
# git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zsh-vi-mode
# source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh

# cd dir_name can be input as dir_name
setopt AUTO_CD

# global aliases
alias -g L='| less'
alias -g NUL="> /dev/null 2>&1"  # ls exist non_exist NUL  is silenced

# hashes
hash -d github=$HOME/Documents/Github   # cd ~github   made easy
hash -d wip=$HOME/Desktop/temp   # cd ~wip    easier, to be updated

# alias completion
# setopt COMPLETE_ALIASES   # no evident difference