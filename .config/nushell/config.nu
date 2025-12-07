# config.nu
#
# Installed by:
# version = "0.108.0"
#
# See https://www.nushell.sh/book/configuration.html
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

$env.config.buffer_editor = "nvim"
$env.config.use_kitty_protocol = false
$env.config.shell_integration.osc133 = false
$env.config.shell_integration.osc633 = false

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
