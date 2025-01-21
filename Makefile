# Must override on first install
host := $(shell hostname)

default: nixos-test

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
	cp /etc/nixos/hardware-configuration.nix nixos/nixos/hardware-configuration.nix

nixos-test: check-host
	sudo nixos-rebuild test --flake path:./nixos#$(host)

nixos-switch: check-host
	sudo nixos-rebuild switch --flake path:./nixos#$(host)

nixos-boot: check-host
	sudo nixos-rebuild boot --flake path:./nixos#$(host)

asdf-install:
	asdf plugin add nodejs
	asdf install nodejs latest
	asdf global nodejs latest

	asdf plugin add golang
	asdf install golang latest
	asdf global golang latest

doom-install:
	$(HOME)/.config/emacs/bin/doom install

doom-sync:
	$(HOME)/.config/emacs/bin/doom sync

emacs-restart:
	systemctl --user restart emacs.service

doom-reload: doom-sync emacs-restart

install: stow nix-os-cp-hardware nixos-switch asdf-install doom-install doom-reload
