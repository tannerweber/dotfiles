# Prints out the colors for colorschemes

def 'f' [name: string, hex: string] {
    let name_len: int = $name | str length
	let colors = {
		fg: '#ffffff'
		bg: $hex
	}
	let padding_length: int = 80 - $name_len

    print -n $"(ansi --escape $colors)($name)"
    for i in (seq 1 $padding_length) {
        print -n $"(ansi --escape $colors) "
    }
    print $"(ansi reset)"
}

# Source: https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/storm.lua
print
print "---------------------------------- TOKYO NIGHT STORM ---------------------------"
f bg "#24283b"
f bg_dark "#1f2335"
f bg_dark1 "#1b1e2d"
f bg_highlight "#292e42"
f blue "#7aa2f7"
f blue0 "#3d59a1"
f blue1 "#2ac3de"
f blue2 "#0db9d7"
f blue5 "#89ddff"
f blue6 "#b4f9f8"
f blue7 "#394b70"
f comment "#565f89"
f cyan "#7dcfff"
f dark3 "#545c7e"
f dark5 "#737aa2"
f fg "#c0caf5"
f fg_dark "#a9b1d6"
f fg_gutter "#3b4261"
f green "#9ece6a"
f green1 "#73daca"
f green2 "#41a6b5"
f magenta "#bb9af7"
f magenta2 "#ff007c"
f orange "#ff9e64"
f purple "#9d7cd8"
f red "#f7768e"
f red1 "#db4b4b"
f teal "#1abc9c"
f terminal_black "#414868"
f yellow "#e0af68"
f git_add "#449dab"
f git_change "#6183bb"
f git_delete "#914c54"

# Source: https://starship.rs/presets/pastel-powerline
print
print "---------------------------------- PASTEL LINE ---------------------------------"
f color1 "#9A348E"
f color2 "#DA627D"
f color3 "#FCA17D"
f color4 "#86BBD8"
f color5 "#06969A"
f color6 "#33658A"

# Source: https://github.com/catppuccin/tmux/blob/main/themes/catppuccin_mocha_tmux.conf
print
print "---------------------------------- CATPUCCIN MOCHA -----------------------------"
f bg "#1e1e2e"
f fg "#cdd6f4"

# Colors
f rosewater "#f5e0dc"
f flamingo "#f2cdcd"
f pink "#f5c2e7"
f mauve "#cba6f7"
f red "#f38ba8"
f maroon "#eba0ac"
f peach "#fab387"
f yellow "#f9e2af"
f green "#a6e3a1"
f teal "#94e2d5"
f sky "#89dceb"
f sapphire "#74c7ec"
f blue "#89b4fa"
f lavender "#b4befe"

# Surfaces and overlays
f subtext_1 "#a6adc8"
f subtext_0 "#bac2de"
f overlay_2 "#9399b2"
f overlay_1 "#7f849c"
f overlay_0 "#6c7086"
f surface_2 "#585b70"
f surface_1 "#45475a"
f surface_0 "#313244"
f mantle "#181825"
f crust "#11111b"
