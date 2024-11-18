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

# ファイル名を変数に入れる
cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$HOME/.config/sheldon/plugins.toml"

# キャッシュがない、またはキャッシュが古い場合にキャッシュを作成
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p $cache_dir
  sheldon source > $sheldon_cache
fi

source "$sheldon_cache"

# 使い終わった変数を削除
unset cache_dir sheldon_cache sheldon_toml
