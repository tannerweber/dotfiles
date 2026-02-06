# config.nu
#
# pretty-print and page through the documentation
#     config nu --doc | nu-highlight | less -R

# Aliases
alias la = ls -a
alias d = ls -a
alias c = clear
alias gs = git status
alias gd = git diff
alias gl = git log
alias gc = git commit -m
alias gb = git branch
alias grv = git remote -v
alias gad = git add .
alias gau = git add -u
alias gaa = git add -A
alias gpom = git push origin main
alias n = nvim

# Preferences
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false
$env.config.table.mode = "none"
$env.config.table.index_mode = "never"
$env.config.table.padding.left = 0
$env.config.table.padding.right = 0

# Terminal compatability
$env.config.use_kitty_protocol = false
$env.config.shell_integration.osc133 = false
$env.config.shell_integration.osc633 = false

# Bat
$env.MANPAGER = 'bat -plman'

# Yazi
try {
	if $env.windir != "" {
		$env.YAZI_FILE_ONE = 'C:/Program Files/Git/usr/bin/file.exe'
	}
}
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# Zoxide
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

# Starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
