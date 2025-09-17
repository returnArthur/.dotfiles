# 🚀 My Arch Linux Dotfiles Setup

---
## 0.Stow
```bash
sudo pacman -S stow

#to stow dir you just need to do
stow ...dirname

#if .dotfiles isnt in home dir you need to do 
stow -t ~ ...dirname

```

## 1. TPM

```bash
#required for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
## 2. Fonts

```bash
sudo pacman -S ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common noto-fonts noto-fonts-emoji ttf-dejavu
sudo pacman -S ttf-jetbrains-mono-nerd
yay -S ttf-font-awesome-4
yay -S ttf-material-design-icons

#do it at the end
fc-cache -fv


```
## 3. Audio

```bash
#remove old audio servers
sudo pacman -Rns pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-zeroconf pulseaudio-jack

#install pipewire & its compnents
sudo pacman -Syu pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber pavucontrol bluez bluez-utils

#enable services
systemctl --user enable --now pipewire pipewire-pulse wireplumber
sudo systemctl enable --now bluetooth

#for restarting services
systemctl --user restart pipewire pipewire-pulse wireplumber
sudo systemctl restart bluetooth

```
## 4. For Nvim & Hyprland(minimal install)

```bash
sudo pacman -S npm ripgrep fzf unzip
```
```bash
sudo pacman -S dolphin nvim hyprland yazi curl wget rofi waybar hyprshot
```
## 5. Greeter

```bash
yay -S greetd-tuigreet

sudo nvim /etc/greetd/config.toml
```
```bash
#inside toml file
[terminal]
vt = 1

[default_session]
command = "tuigreet --cmd Hyprland"
user = "greeter"
```
```bash
sudo systemctl enable greetd.service

#for starting immediately
sudo systemctl start greetd.service

```
