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
	cp /etc/nixos/hardware-configuration.nix nix/os/hardware-configuration.nix

nixos-test: check-host stow
	sudo nixos-rebuild test --flake path:$(HOME)/dotfiles/nix#$(host)

nixos-switch: check-host stow
	sudo nixos-rebuild switch --flake path:$(HOME)/dotfiles/nix#$(host)

nixos-boot: check-host stow
	sudo nixos-rebuild boot --flake path:$(HOME)/dotfiles/nix#$(host)

nixos-update: check-host stow
	nix flake update --flake path:$(HOME)/dotfiles/nix
	sudo nixos-rebuild boot --upgrade --flake path:$(HOME)/dotfiles/nix#$(host)

darwin-switch: stow
	sudo darwin-rebuild switch --flake path:$(HOME)/dotfiles/nix#$(host)

darwin-update: stow
	nix flake update --flake path:$(HOME)/dotfiles/nix
	sudo darwin-rebuild switch --flake path:$(HOME)/dotfiles/nix#$(host)

install: check-host stow nixos-cp-hardware nixos-boot

install-server: check-host nixos-cp-hardware nixos-boot
