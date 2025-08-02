# KEY BINDS
bindkey -e

# PROMPT
autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

PROMPT="%F{231}╭──%f%F{183}%f%K{183}%F{231} 󰪫 %f%k%K{183}%F{231}%M%f%k%K{183}%F{231} %f%k%K{72}%F{183}%f%k%K{72}%F{231}  %f%k%K{72}%F{231}%n%f%k%K{72}%F{231} %f%k%K{11}%F{72}%f%k%K{11}%F{231} 󰝰 %f%k%K{11}%F{black}%~%f%k%K{11}%F{231} %f%k%K{197}%F{11}%f%k%K{197}%F{231}  %f%k%K{197}%F{231}%t%f%k%K{197}%F{231} %f%k%F{197}%f
%F{231}╰───%f "


# HISTORY
setopt histignorealldups sharehistory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.config/zsh/.zsh_history


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


# NVIM path
export PATH="$HOME/.local/nvim-linux-x86_64/bin:$PATH"


# LS
LS_COLORS='di=1;33:*.o=0;34:*.txt=01;31'
export LS_COLORS
alias ls='ls --color=auto'


# Output working
echo "zshrc functioning\n"


# Syntax Highlighting
# Has to be at the end of file
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # https://github.com/zsh-users/zsh-syntax-highlighting
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh # https://github.com/zsh-users/zsh-autosuggestions
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh # https://github.com/zsh-users/zsh-history-substring-search

# zsh-history-substring-search options
bindkey '^[[1;5A' history-substring-search-up
bindkey '^[[1;5B' history-substring-search-down
