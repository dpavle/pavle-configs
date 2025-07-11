
# Getting Started

## NixOS

```bash
sudo nixos-rebuild switch --flake ./#pavle-nixos
```

## Home (home-manager)

```bash
home-manager switch --flake .#pavle@pavle-nixos
```

## dotfiles (GNU Stow)

```bash
cd dotfiles
stow -t ~/ .
```
