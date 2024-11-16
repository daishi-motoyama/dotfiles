# Dotfiles

![neovim-preview](https://github.com/user-attachments/assets/2fb9040f-b4c4-42fe-83be-cca391371702)

## Setup

最初に行う必要があるのは、このリポジトリのクローンを選択した場所に作成することです。
このリポジトリはドットファイルの場所に依存しないように設定されているため、どこにでも配置できます。

### `backup`

```bash
./install.sh backup
```

現在のドットファイル (存在する場合) のバックアップを `~/.dotfiles-backup/` に作成します。
[XDG base directory](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html),
(`~/.config`).

- `~/.config/nvim/` - The home of [neovim](https://neovim.io/) configuration
- `~/.vim/` - The home of vim configuration
- `~/.vimrc` - The main init file for vim

### `link`

```bash
./install.sh link
```

`link` コマンドは、dotfiles ディレクトリから `$home` ディレクトリにシンボリックリンクを作成し、すべての設定を同じように実行できるようにします。
