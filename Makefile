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
	sudo nixos-rebuild boot --upgrade --flake path:$(HOME)/dotfiles/nixos#$(host)

install: check-host stow nixos-cp-hardware nixos-boot

install-server: check-host nixos-cp-hardware nixos-boot

