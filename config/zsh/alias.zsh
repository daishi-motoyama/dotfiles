#! /usr/bin/env zsh

# https://gist.github.com/AppleBoiy/04a249b6f64fd0fe1744aff759a0563b
abbr -g ll='eza -la --icons --octal-permissions --group-directories-first'
abbr -g l='eza -bGF --header --git --color=always --group-directories-first --icons'
abbr -g llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons' 
abbr -g la='eza --long --all --group --group-directories-first'
abbr -g lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'
abbr -g lS='eza -1 --color=always --group-directories-first --icons'
abbr -g lt='eza --tree --level=2 --color=always --group-directories-first --icons'

#upstairs
abbr -g ...='cd ../..'
abbr -g ....='cd ../../..'
abbr -g .....='cd ../../../..'
abbr -g ......='cd ../../../../..'

# git
abbr -g gl="git log --graph --all --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %an, %ar%Creset'"
abbr -g gll="git log --stat --abbrev-commit"
abbr -g glg="git log --color --graph --pretty=format:'%C(bold white)%h%Creset -%C(bold green)%d%Creset %s %C(bold green)(%cr)%Creset %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
abbr -g gllg="git log --color --graph --pretty=format:'%C(bold white)%H %d%Creset%n%s%n%+b%C(bold blue)%an <%ae>%Creset %C(bold green)%cr (%ci)' --abbrev-commit"

# colima
abbr -g cst="colima status"
abbr -g csr="colima start"
abbr -g csp="colima stop"

