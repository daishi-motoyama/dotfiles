#!/usr/bin/env zsh

function sync_brew() {
  brewfile_link_path=$(readlink -f ~/.config/homebrew/Brewfile)

  installed_packages=$(brew leaves && brew list --cask)

  brewfile_packages=$(rg "^(tap|brew|cask)" "$brewfile_link_path" | awk '{gsub(/"/, "", $2); print $2}')

  echo "Install packages listed in the .brewfile but not installed:"

  installed_any=false
  while read -r package; do
    if ! echo "$installed_packages" | rg "^$package$"; then
      echo "During installation:$package"
      brew install "$package"
      installed_any=true
    fi
  done < <(echo "$brewfile_packages")

  if [ "$installed_any" = false ]; then
    echo "all packages already installed"
    return 0
  fi

  echo "Add any installed packages that are not listed in the .brewfile to the .brewfile:"

  installed_any=false
  while read -r package; do
    if ! echo "$brewfile_packages" | rg "^$package$"; then
      installed_any=true
    fi
  done < <(echo "$installed_packages")

  if [ "$installed_any" = false ]; then
    echo "All packages are already listed in .brewfile"
  else
    echo "The contents of .brewfile and the actual installation situation do not match"
    echo "Regenerate .brewfile"
    brew bundle dump --force --file="$brewfile_link_path"
  fi
}

alias bs="sync_brew"
abbr -g bs="sync_brew"
