alias c='pbcopy'
alias p='pbpaste'
alias gauth='gcloud auth login && gcloud auth application-default login'
alias dva='detach-verify-address'
alias adi='./utils/address-info'
alias ansible-playbook='sig-ansible-playbook'
alias make='sig-make'
alias terraform='sig-terraform'

alias po='polysign'
alias gsm="git-sig-merge"
alias cs="cd ~/u410/cs"
alias cso='polyrun ./cso'

export GONOPROXY='go.u4hq.dev'
export GOPRIVATE='go.u4hq.dev'
export GOSUMDB='sum.golang.org'
# export GOPROXY='direct'
export GOPROXY="https://proxy.golang.org,direct"
export GONOSUMDB='*'

eval "$(/opt/homebrew/bin/brew shellenv)"

psb() {
    git fetch
    git checkout "$1"
    git pull
    polysign
    git checkout -
}

path_prepends=(
    # /opt/homebrew/opt/cpio/bin
    # /opt/homebrew/opt/gnu-tar/libexec/gnubin
    /opt/homebrew/opt/findutils/libexec/gnubin
    /opt/homebrew/opt/curl/bin
    /opt/homebrew/opt/grep/libexec/gnubin
    /opt/homebrew/opt/coreutils/libexec/gnubin
)

path_appends=(
    ~/u410/gnupg-m1-builder/target/bin
    ~/u410/sig-utils/utils
    ~/u410/cs/scripts
    ~/u410/horcrux
    ~/google-cloud-sdk/bin
)

# We don't want quotes here for the functions to work correctly
# shellcheck disable=SC2086,SC2128
path_prepend $path_prepends
# shellcheck disable=SC2086,SC2128
path_append $path_appends
