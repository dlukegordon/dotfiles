# dotfiles

![](https://i0.wp.com/globalpragmatica.com/wp-content/uploads/2010/10/Mandelbrot.jpeg)

My personal dotfiles including configs for NixOS, KDE Plasma, Neovim, Tmux, Ghostty, and Nushell.

## NixOS setup

### Install the base os

- Download the latest [NixOS Plasma ISO](https://nixos.org/download/).
- Flash it to a USB drive.
- Boot into it and install as normal. Be sure to pick the Plasma 6 desktop environment and set the username to `luke`.

### Install the full system

We can now install the full system. These commands will clone the repo, link the dotfiles into `~`, and apply the NixOS configuration. Set `new_host` to the hostname for the configuration from [flake.nix](nixos/flake.nix) you are installing.

If you are installing the server, run `make install-server` instead of `make install`.

The below commands are in bash, as nushell will not be installed at this point.

```bash
cd ~
nix-shell -p git gnumake stow --extra-experimental-features 'nix-command flakes'
new_host="<set hostname from flake.nix>"
git clone https://github.com/dlukegordon/dotfiles.git
cd dotfiles
make install host=$new_host
reboot
```
