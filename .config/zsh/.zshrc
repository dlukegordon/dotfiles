export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/usr/local/bin:$PATH"
    export PATH="$HOME/.nix-profile/bin:$PATH"
    export PATH="/etc/profiles/per-user/$USER/bin:$PATH"
    export PATH="/run/current-system/sw/bin:$PATH"
    export PATH="/nix/var/nix/profiles/default/bin:$PATH"
    export PATH="$HOME/.local/share/mise/shims:$PATH"
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
fi

export EDITOR='nvim'
export VISUAL='nvim'
