# configs
Config files for different tools.

### Mac dependencies
First install [brew](https://brew.sh/).

Reload terminal, then install brew dependencies:
```
brew doctor
brew update
brew install git wezterm tmux neovim ripgrep grep re2 gawk lolcat fd cmake fish aspell gpa lsd
```

### Arch dependencies
```
sudo pacman -Syu
sudo pacman -S nvidia base-devel pkg-config vim neovim lsd git-delta stow wezterm fish tk ripgrep fd jq wireguard-tools xclip ccid opensc bc tmux fzf zoxide cmake re2 pybind11 yay unzip texlive-latex texlive-latexextra texlive-latexrecommended texlive-plaingeneric
```

### Aur deps
```
yay -S nvimpager ivpn ivpn-ui
```

### Debian dependencies
```
sudo apt install git vim ripgrep tmux apt-transport-https curl stow texinfo imagemagick jq fd-find tk-dev cmake shellcheck graphviz markdown resolvconf aspell aspell-en gpa libxpm-dev libgif-dev libgnutls28-dev libncurses-dev libx11-dev libgtk-3-dev ligmagickcore-dev libmagick++-dev libgccjit-10-dev libjansson-dev libreadline-dev libssl-dev libsqlite3-dev libvterm-dev
```

### Additional Linux kernel params (with nvidia gpu)
```
ibt=off nvidia_drm.modeset=1
```

### Install configs
```
git clone git@github.com:dlukegordon/configs.git ~/configs
cd configs
stow . --target=$HOME
```

### Set zsh as default
chsh -s $(which zsh)
sudo chsh -s $(which zsh)

### Install rust packages
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Not needed on arch
cargo install --git https://github.com/Peltoche/lsd.git --branch master

cargo install tmux-sessionizer
```

### Install node and python with asdf
```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
<reload shell>
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest
asdf plugin add python
asdf install python latest
asdf global python latest
asdf plugin add golang
asdf install golang latest
asdf global golang latest
```

### Add yubikey GPG key
```
# First download the yubikey pub key from Bitwarden
gpg --import pub.pgp
```

### Fonts
- [Roboto Mono NF](https://www.nerdfonts.com/font-downloads)
- [FiraCode NF](https://www.nerdfonts.com/font-downloads)
- [Bookerly](https://www.cufonfonts.com/font/bookerly)
- [ETBembo](https://github.com/edwardtufte/et-book/tree/gh-pages/et-book)
- Mac emojis: [EmojiOne](https://github.com/adobe-fonts/emojione-color/blob/master/EmojiOneColor.otf)
- Debian emojis: [Noto Color Emoji](https://fonts.google.com/noto/specimen/Noto+Color+Emoji)
- `defaults write org.gnu.Emacs AppleFontSmoothing -int 16  # Make fonts look less thick in emacs`


### Setup gitconfig
We aren't adding this to the repo directory since this will differ a lot per machine (for example a work machine will have a different email).

Copy the following into `~/.gitconfig`, and add to as necessary:
```
[commit]
	gpgsign = true
[user]
	signingkey =
	name = 
	email = 
[alias]
	logs = log --show-signature
	commit = commit -S
[tag]
	forceSignAnnotated = true
[push]
	autoSetupRemote = true
[pull]
	rebase = true
[url "git@gitlab.com:"]
	insteadOf = https://gitlab.com/
[remote "origin"]
	tagopt = --tags
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
[color "diff"]
	meta = blue normal bold
	old = red normal bold
	new = green normal bold
[core]
	pager = less -RXF
```

### Setup Firefox
Install these extensions:
- [Tree Style Tab](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/)
- [TST Indent Line](https://addons.mozilla.org/en-US/firefox/addon/tst-indent-line/)
- [TST More Tree Command](https://addons.mozilla.org/en-US/firefox/addon/tst-more-tree-commands/)
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)

Use this theme: [Arc Dark Theme](https://addons.mozilla.org/en-US/firefox/addon/arc-dark-theme-we/)

Add this to `userChrome.css`:
```
#TabsToolbar {
  visibility: collapse;
}

#tracking-protection-icon-container {
	display: none;
}

#sidebar-header {
  display: none;
}
```

Change these settings in `about:config`
```
browser.warnOnQuit false
browser.aboutConfig.showWarning false
browser.warnOnQuit false
identity.fxaccounts.enabled false
sidebar.revamp false
```

### Pip dependencies
Install pip dependencies:
```
pip install debugpy pynvim black pyflakes isort pipenv nose pytest poetry neovim
```

### Neovim
Open neovim:
```
cd ~
nvim
```

Ignore all the errors, and let Lazy load all the plugins. Then reload neovim.

Run:
```
:UpdateRemotePlugins
```

Install Mason packages
```
:MasonInstall lua-language-server rust-analyzer codelldb gopls golangci-lint-langserver delve yaml-language-server bash-language-server
```

### End
You are done! Enjoy 🎉!
