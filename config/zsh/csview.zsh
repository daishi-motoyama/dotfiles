#! /usr/bin/env zsh

function view_csv() {
  local charset=$(file -b --mime-encoding "$1")

  if [[ "$charset" != "utf-8" ]]; then
    echo "Converting from $charset to UTF-8"
    iconv -f "$charset" -t UTF-8//TRANSLIT "$1" | csview --style rounded
    return 0
  fi

  csview --style rounded "$1"
}

alias csv="view_csv"
abbr -g csv="view_csv"
