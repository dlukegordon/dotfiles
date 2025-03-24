# Must override on first install
host := $(shell hostname)

default: stow nixos-test

switch: stow nixos-switch

check-host:
	@if [ "$(host)" = "nixos" ]; then \
		echo "Error: Host is set to default: nixos"; \
		echo "Try running again with a host specified, ie:"; \
		echo "  make install host=valhalla"; \
		exit 1; \
	fi

stow:
	stow . --target=$(HOME)

nixos-cp-hardware:
	cp /etc/nixos/hardware-configuration.nix nixos/os/hardware-configuration.nix

nixos-test: check-host
	sudo nixos-rebuild test --flake path:$(HOME)/dotfiles/nixos#$(host)

nixos-switch: check-host
	sudo nixos-rebuild switch --flake path:$(HOME)/dotfiles/nixos#$(host)

nixos-boot: check-host
	sudo nixos-rebuild boot --flake path:$(HOME)/dotfiles/nixos#$(host)

nixos-update:
	nix flake update --flake path:$(HOME)/dotfiles/nixos

asdf-install:
	asdf plugin add nodejs
	asdf install nodejs latest
	asdf global nodejs latest

	asdf plugin add golang
	asdf install golang latest
	asdf global golang latest

doom-install:
	git clone --depth 1 https://github.com/doomemacs/doomemacs $(HOME)/.config/emacs
	$(HOME)/.config/emacs/bin/doom install
	$(HOME)/.config/emacs/bin/doom sync

doom-sync:
	$(HOME)/.config/emacs/bin/doom sync

emacs-restart:
	systemctl --user restart emacs.service

doom-reload: doom-sync emacs-restart

install-1: check-host stow nixos-cp-hardware nixos-boot

install-2: asdf-install doom-install doom-reload nixos-switch
