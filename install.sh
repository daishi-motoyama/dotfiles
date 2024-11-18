#!/usr/bin/env bash

# 下記のリポジトリを参考に実装
# https://github.com/nicknisi/dotfiles/blob/699b1327404b826df285e997e14ddac3a08cb7a2/install.sh 

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

linkables=(
  # "zsh/.zshrc"
  # "zsh/.zshenv"
  # "zsh/.zprofile"
)

# Configuration home
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
data_home="${XDG_DATA_HOME:-$HOME/.local/share}"

title() {
  echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
  echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
  echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
  exit 1
}

warning() {
  echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
  echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
  echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

backup() {
  BACKUP_DIR=$HOME/dotfiles-backup

  echo "Creating backup directory at $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"

  for file in "${linkables[@]}"; do
    filename="$(basename "$file")"
    target="$HOME/$filename"
    if [ -f "$target" ]; then
      echo "backing up $filename"
      cp "$target" "$BACKUP_DIR"
    else
      warning "$filename does not exist at this location or is a symlink"
    fi
  done

  for filename in "$HOME/.config/nvim" "$HOME/.vim" "$HOME/.vimrc"; do
    if [ ! -L "$filename" ]; then
      echo "backing up $filename"
      cp -rf "$filename" "$BACKUP_DIR"
    else
      warning "$filename does not exist at this location or is a symlink"
    fi
  done
}

cleanup_symlinks() {
  title "Cleaning up symlinks"
  for file in "${linkables[@]}"; do
    target="$HOME/$(basename "$file")"
    if [ -L "$target" ]; then
      info "Cleaning up \"$target\""
      rm "$target"
    elif [ -e "$target" ]; then
      warning "Skipping \"$target\" because it is not a symlink"
    else
      warning "Skipping \"$target\" because it does not exist"
    fi
  done

  echo -e
  info "installing to $config_home"

  config_files=$(find "$DOTFILES/config" -maxdepth 1 2>/dev/null)
  for config in $config_files; do
    target="$config_home/$(basename "$config")"
    if [ -L "$target" ]; then
      info "Cleaning up \"$target\""
      rm "$target"
    elif [ -e "$target" ]; then
      warning "Skipping \"$target\" because it is not a symlink"
    else
      warning "Skipping \"$target\" because it does not exist"
    fi
  done
}

setup_symlinks() {
  title "Creating symlinks"

  for file in "${linkables[@]}"; do
    target="$HOME/$(basename "$file")"
    if [ -e "$target" ]; then
      info "~${target#"$HOME"} already exists... Skipping."
    else
      info "Creating symlink for $file"
      ln -s "$DOTFILES/$file" "$target"
    fi
  done

  echo -e
  info "installing to $config_home"
  if [ ! -d "$config_home" ]; then
    info "Creating $config_home"
    mkdir -p "$config_home"
  fi

  if [ ! -d "$data_home" ]; then
    info "Creating $data_home"
    mkdir -p "$data_home"
  fi

  config_files=$(find "$DOTFILES/config" -maxdepth 1 2>/dev/null)
  for config in $config_files; do
    target="$config_home/$(basename "$config")"
    if [ -e "$target" ]; then
      info "~${target#"$HOME"} already exists... Skipping."
    else
      info "Creating symlink for $config"
      ln -s "$config" "$target"
    fi
  done

  # symlink .zshenv into home directory to properly setup ZSH
  if [ ! -e "$HOME/.zshenv" ]; then
    info "Creating symlink for .zshenv"
    ln -s "$DOTFILES/config/zsh/.zshenv" "$HOME/.zshenv"
  else
    info "~/.zshenv already exists... Skipping."
  fi
}

DOCKER_CLI_PLUGINS_DIR=$HOME/.docker/cli-plugins

install_docker_compose() {
  # https://docs.docker.com/compose/install/linux/#install-the-plugin-manually
  if [ -f "$DOCKER_CLI_PLUGINS_DIR/docker-compose" ]; then
    info "Docker compose is already installed, so skip it."
  else
    title "Installing Docker Compose"
    mkdir -p "$DOCKER_CLI_PLUGINS_DIR"   
    curl -SL "https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-darwin-aarch64" -o "$DOCKER_CLI_PLUGINS_DIR/docker-compose"
    chmod +x "$DOCKER_CLI_PLUGINS_DIR/docker-compose"
    info "Installed docker compose"
  fi
}

case "$1" in
backup)
  backup
  ;;
clean)
  cleanup_symlinks
  ;;
link)
  setup_symlinks
  ;;
docker)
  install_docker_compose
  ;;
all)
  setup_symlinks
  ;;
*)
  echo -e $"\nUsage: $(basename "$0") {backup|link|git|homebrew|shell|terminfo|macos|all}\n"
  exit 1
  ;;
esac

echo -e
success "Done."
