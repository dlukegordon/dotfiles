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
  git checkout $1
  git pull
  polysign
  git checkout -
}

# Eject SD or usb storage devices
# e() {
#   local vpaths=(BOOT TRANSPORT ROM FIRMWARE)
#     
#   for vpath in "${vpaths[@]}"; do
#     path="/Volumes/$vpath"
#     if [[ -e "$vpath" ]]; then
#       echo "Ejecting $vpath..."
#       diskutil eject "$vpath"
#     fi
#   done
# }

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

path-prepend $path_prepends
path-append $path_appends
