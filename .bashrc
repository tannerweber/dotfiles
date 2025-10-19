# Tanner Weber
# tannerw@pdx.edu

# PATH
export PATH="$HOME/.local/nvim-linux-x86_64/bin:$PATH"

# ALIASES
alias ls='ls --color=auto'

# HISTORY
HISTFILE=~/.config/bash/.bash_history

# PROMPT
#PS1=$'\n\[\e[38;5;244m\]\u256D\u2500\u2500\[\e[38;5;153m\] (\u@\H) \[\e[38;5;231m\]\w\[\e[38;5;244m\]\n\u2570\u2500\u2500\u2500\u2192\[\e[0m\] '
PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='(\u@\H) \w (${PS1_CMD1}) \@ \s\n\\$ '

eval "$(starship init bash)"
. "$HOME/.cargo/env"
