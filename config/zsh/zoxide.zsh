#!/usr/bin/env zsh

# https://github.com/ajeetdsouza/zoxide/issues/792
autoload -Uz compinit && compinit
eval "$(zoxide init zsh)"
