# XDG
export XDG_CONFIG_HOME="${HOME}/.config"

# zshの設定ファイル格納ディレクトリパス
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# 履歴ファイルの保存先
export HISTFILE="${HOME}/.zsh_history"

# メモリ保存される履歴の件数
export HISTSIZE=10000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=10000

# lang
export LANGUAGE="ja_JP.UTF-8"
export LANG="${LANGUAGE}"

# editer
export EDITOR="nvim"
export GIT_EDITOR="${EDITOR}"

# starshipの設定ファイルパス
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

NAVI_DIR="${XDG_CONFIG_HOME}/navi"

# navimの設定ファイルパス
export NAVI_CONFIG="${NAVI_DIR}/config.yaml"

export NAVI_PATH="${NAVI_DIR}/cheats:.cheats"
