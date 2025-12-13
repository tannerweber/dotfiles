# config.nu
#
# pretty-print and page through the documentation
#     config nu --doc | nu-highlight | less -R

# Aliases
alias la = ls -a
alias gs = git status
alias gd = git diff
alias gl = git log
alias gc = git commit -m

# Preferences
$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

# Terminal compatability
$env.config.use_kitty_protocol = true
$env.config.shell_integration.osc133 = false
$env.config.shell_integration.osc633 = false

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
