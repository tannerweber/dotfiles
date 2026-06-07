# fzf
fzf --fish | source

# bat
set -x MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

# yazi
function y
set tmp (mktemp -t "yazi-cwd.XXXXXX")
yazi $argv --cwd-file="$tmp"
if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    builtin cd -- "$cwd"
end
rm -f -- "$tmp"
end

# zoxide
if test -n "(which zoxide)"
    zoxide init fish | source
    abbr --add cd "z"
end

# starship.rs
starship init fish | source
