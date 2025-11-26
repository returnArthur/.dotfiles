#!/usr/bin/env bash
# -----------------------------------------
# 🚀 Arch Linux Dotfiles Setup Installer (SAFE VERSION)
# -----------------------------------------

set -e  # Exit on error

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

# -----------------------------------------------------
# 0. GNU Stow
# -----------------------------------------------------
echo "==> Installing GNU Stow..."
sudo pacman -S --needed --noconfirm stow

echo "==> Preparing dotfiles directory..."

# Create dotfiles directory safely
mkdir -p ~/Projects/dotfiles
cd ~/Projects/dotfiles

# Only run stow if folders exist
for pkg in hypr kitty nvim rofi scripts tmux waybar zsh; do
  if [ -d "$pkg" ]; then
    echo "--> Stowing $pkg"
    stow -t ~ "$pkg"
  else
    echo "WARNING: '$pkg' folder not found. Skipping."
  fi
done

# -----------------------------------------------------
# 1. TPM (Tmux Plugin Manager)
# -----------------------------------------------------
echo "==> Setting up TPM..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "TPM already installed."
fi

# -----------------------------------------------------
# 2. Fonts
# -----------------------------------------------------
echo "==> Installing fonts..."
sudo pacman -S --needed --noconfirm \
  ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-common \
  noto-fonts \
  noto-fonts-emoji \
  ttf-dejavu \
  ttf-jetbrains-mono-nerd

# AUR fonts via yay
if ! command -v yay &>/dev/null; then
  echo "==> Installing yay (AUR helper)..."
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
  cd -
fi

echo "==> Installing AUR fonts..."
yay -S --needed --noconfirm ttf-font-awesome-4 ttf-material-design-icons

echo "==> Refreshing font cache..."
fc-cache -fv

# -----------------------------------------------------
# 3. Audio (PipeWire setup)
# -----------------------------------------------------
echo "==> Removing PulseAudio (safe)..."
sudo pacman -Rns pulseaudio* || true

echo "==> Installing PipeWire and components..."
sudo pacman -S --needed --noconfirm \
  pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber \
  pavucontrol bluez bluez-utils

echo "==> Enabling audio and bluetooth services..."
systemctl --user enable --now pipewire pipewire-pulse wireplumber
sudo systemctl enable --now bluetooth

# -----------------------------------------------------
# 4. Nvim & Hyprland (Minimal install)
# -----------------------------------------------------
echo "==> Installing base tools for Nvim & Hyprland..."
sudo pacman -S --needed --noconfirm npm ripgrep fzf unzip \
  dolphin nvim hyprland yazi curl wget rofi waybar hyprshot \
  nodejs npm

# -----------------------------------------------------
# 5. Greeter (tuigreet + greetd)
# -----------------------------------------------------
echo "==> Installing tuigreet..."
yay -S --needed --noconfirm greetd-tuigreet

echo "==> Configuring greetd..."

# Ensure directory exists
sudo mkdir -p /etc/greetd

sudo tee /etc/greetd/config.toml >/dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "tuigreet --cmd hyprland"
user = "greeter"
EOF

echo "==> Enabling greetd service..."
sudo systemctl enable --now greetd.service

echo " "
echo "========================================="
echo "     ✅ Setup complete! Reboot now.      "
echo "========================================="

