# . $ZDOTDIR/zim.zsh
# . $ZDOTDIR/aliases.sh
# . $ZDOTDIR/funcs.sh

if [ -f "$ZDOTDIR/gitignored.sh" ]; then
    . "$ZDOTDIR/gitignored.sh"
fi

# Newline before prompt except the first
# precmd() { precmd() { echo } }

# Keybindings
# bindkey -e
# autoload -z edit-command-line
# zle -N edit-command-line
# bindkey "^X^E" edit-command-line
# bindkey '^\' forward-word
# bindkey "^[[3~" delete-char
# bindkey "^[[1;5C" forward-word
# bindkey "^[[1;5D" backward-word

# Tools
# if [[ ! -e "/etc/NIXOS" && -d "$HOME/.asdf" ]]; then
#     . "$HOME/.asdf/asdf.sh"
#     fpath=(${ASDF_DIR}/completions $fpath)
#     # autoload -Uz compinit && compinit
# fi
# if [[ ! -e "/etc/NIXOS" && -d "$HOME/.cargo/" ]]; then
#     . "$HOME/.cargo/env"
# fi

## General env vars
# export EDITOR='nvim'
# export VISUAL="$EDITOR"
# export PAGER=nvimpager
# export LESS='--mouse --wheel-lines=1'
# export LS_COLORS="ow=100;37;01"
# export FZF_DEFAULT_OPTS="--pointer='>' --color=bg+:#30363F,fg+:white,gutter:-1,hl:#C98E56,hl+:#C98E56,pointer:#C98E56"

# Work settings
if [[ "$HOST" == "lgordon-m2-mbp" ]]; then
    . $ZDOTDIR/work.sh
fi

# GPG
export GPG_TTY="$TTY"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpg-agent --homedir ~/.gnupg --daemon --enable-ssh-support > /dev/null 2>&1
gpg-connect-agent updatestartuptty /bye > /dev/null

# Paths
# path_prepend ~/.asdf/shims
# path_append ~/scripts ~/.local/bin ~/go/bin ~/.config/emacs/bin
# path_append ~/bin

# OSC7 escape sequence for terminal
# _urlencode() {
#     local length="${#1}"
#     for (( i = 0; i < length; i++ )); do
#         local c="${1:$i:1}"
#         case $c in
#             %) printf '%%%02X' "'$c" ;;
#             *) printf "%s" "$c" ;;
#         esac
#     done
# }
# osc7_cwd() {
#     printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "$(_urlencode "$PWD")"
# }
# autoload -Uz add-zsh-hook
# add-zsh-hook -Uz chpwd osc7_cwd

# Fzf shell integration
# eval "$(fzf --zsh)"
# Zoxide shell integration
# eval "$(zoxide init zsh)"
