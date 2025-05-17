# Alias
## Utils
alias ll='ls -la'

## SSH
alias ssh-pgit='eval $(keychain --eval --agents ssh personal)'
alias ssh-ls='ps ax | grep ssh-agent'
alias ssh-kill='pkill ssh-agent'

## NIX
alias nrs='sudo nixos-rebuild switch -I nixos-config=$HOME/dotfiles/nixos/configuration.nix'
alias ncg='sudo nix-collect-garbage -d && nix-collect-garbage -d'

# Starship
eval "$(starship init bash)"
