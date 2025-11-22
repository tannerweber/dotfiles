# Tanner Weber
# tannerw@pdx.edu

# PATH
export PATH="$HOME/.local/nvim-linux-x86_64/bin:$PATH"

# ALIASES
alias gs="git status"
alias gd="git diff"
alias gl="git log"

# HISTORY
HISTFILE=~/.config/bash/.bash_history

# PROMPT
PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'
PS1=$'\n\[\e[38;5;244m\]\u256D\u2500\[\e[38;5;153m\] (\u@\H) \[\e[38;5;231m\]\w\[\e[38;5;244m\] (${PS1_CMD1}) \@ \s\n\u2570\u2500\u2500\u2192\[\e[0m\] '

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf
eval "$(fzf --bash)"

# ls
LS_COLORS="di=1;33:*.o=0;34:*.txt=01;31"
alias ls="ls --color=auto"
alias la="eza -al --icons"

# bat
MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# zoxide
if [ -n "$(which zoxide)" ]; then
	eval "$(zoxide init bash)"
	alias cd="z"
fi

#eval "$(starship init bash)" # Starship doesn't work with ble.sh
. "$HOME/.cargo/env"

# https://github.com/akinomyoga/ble.sh
source -- ~/.local/share/blesh/ble.sh
