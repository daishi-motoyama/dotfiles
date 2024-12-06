#!/usr/bin/env zsh

# シェル操作をvim互換にする
bindkey -v

# 直前と同じコマンドは記録しない
setopt hist_ignore_dups

# 重複するコマンドは古い方を削除する
setopt hist_ignore_all_dups

# 履歴を複数の端末で共有する
setopt share_history

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# スペースで始まるコマンド行は履歴から削除
setopt hist_ignore_space

# ビープ音を無効にする
setopt no_beep

# 補完候補表示時にビープ音を鳴らさない
setopt nolistbeep

precmd() {
  print -Pn "\e]0;%~\a"
}

precmd
