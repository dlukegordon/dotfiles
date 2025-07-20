# dotfiles

![](https://i0.wp.com/globalpragmatica.com/wp-content/uploads/2010/10/Mandelbrot.jpeg)

My personal dotfiles including configs for NixOS, Hyprland, Neovim, Tmux, Wezterm, and Nushell.

## NixOS setup

### Install the base os

- Download the latest [NixOS Plasma ISO](https://nixos.org/download/).
- Flash it to a USB drive.
- Boot into it and install as normal. Be sure to pick the Plasma 6 desktop environment and set the username to `luke`.

### Install the full system

We can now install the full system. These commands will clone the repo, link the dotfiles into `~`, and apply the NixOs configuration. Set `new_host` to the hostname for the configuration from [flake.nix](nixos/flake.nix) you are installing.

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

After the reboot, log into either Plasma (Wayland) or Hyprland.

### Post install

There are a few things that we can't (currently) setup through NixOS, you'll need to set these up manually.
- Install Zen browser through flatpak (`flatpak install flathub app.zen_browser.zen`) ([note](https://github.com/YaLTeR/niri/issues/1042))
- Set a fingerprint for laptops
- Customize the Plasma panel and task switcher settings.
- Set Plasma display, power, and screen lock settings.
- Generate an ssh key for git. Follow instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent). Then you'll need to update the remote of this repo to use ssh: `git remote set-url origin git@github.com:dlukegordon/dotfiles.git`.

## MacOS Setup

This is a work in progress. For now, refer to [README-old.md](README-old.md). Eventually this will be implemented with [nix-darwin](https://github.com/LnL7/nix-darwin).
