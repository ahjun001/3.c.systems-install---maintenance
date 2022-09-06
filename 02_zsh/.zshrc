

# autoload -Uz promptinit
# promptinit
# prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

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
# bindkey -v

# PROMPTS -- pjp
# PROMPT='%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}:%{$fg[blue]%}%B%~%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '
# RPROMPT='[%*]'
# setopt PROMPT_SUBST
# PROMPT='%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}:%{$fg[blue]%}%B%~%b%{$reset_color%} $(git_prompt_info)%(!.#.$) '
# RPROMPT='%1v [%*]'

autoload -Uz vcs_info
precmd() {
  psvar[1]=$(expressvpn status | grep -q Not && echo 'VPN:Off' || echo 'VPN:On')
# Load version control information
  vcs_info
}
 
autoload -U colors && colors
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git*' formats " %{$fg[magenta]%}%b%{$reset_color%}%m%u%c%{$reset_color%} "
setopt PROMPT_SUBST
RPROMPT='%1v [%*]'
PROMPT='%{$fg[green]%}%n%{$reset_color%}@%{$fg[green]%}%m %{$fg[blue]%}%~ %{$reset_color%}${vcs_info_msg_0_}%(!.#.$)'
