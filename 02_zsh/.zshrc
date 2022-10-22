
# Use modern completion system
autoload -Uz compinit
compinit

autoload -Uz vcs_info
precmd() {
  psvar[1]=$(expressvpn status | grep -q Not && echo 'VPN:Off' || echo 'VPN:On')
# Load version control information
  vcs_info
}
 
setopt PROMPT_SUBST
RPROMPT='%1v [%*]'
PROMPT='%{$fg[green]%}%n %{$fg[blue]%}%~ %{$reset_color%}${vcs_info_msg_0_}%(!.#.$) '