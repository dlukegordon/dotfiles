path-append() {
	for dir in "$@"; do
		PATH="$PATH:$dir"
	done
	export PATH
}

path-prepend() {
	for dir in "$@"; do
		PATH="$dir:$PATH"
	done
	export PATH
}

git-commit-chatgpt() {
	local mesg=$(git diff --staged | cg -c 4 'Generate a very short and concise commit message for this diff.' | awk '{$1=$1};1')
	git commit -m "$mesg"
}

gpg-reset() {
  if [[ "$(killall -s gpg-agent 2>&1)" == "kill"* ]]; then
    sudo killall gpg-agent
  fi
  gpg-agent --homedir ${HOME}/.gnupg --daemon --enable-ssh-support
  gpg --card-status
  export "GPG_TTY=$(tty)"
  export "SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh"
}

unalias gco
gco() {
    local branch="$1"
    
	# Direct checkout if branch exists (locally or remotely)
    if [ -n "$branch" ] && ( \
		git show-ref --verify --quiet refs/heads/"$branch" \
		|| git show-ref --verify --quiet refs/remotes/origin/"$branch" \
	); then
        git checkout "$branch"
        return
    fi
    
    # Fuzzy find branch, with optional initial query
    local selected_branch=$(git branch -a | cut -c 3- | fzf ${branch:+--query="$branch"})
    if [ -n "$selected_branch" ]; then
		# Remove 'remotes/origin/' prefix if present
        selected_branch=${selected_branch#remotes/origin/}
        git checkout "$selected_branch"
    fi
}
