#!/bin/sh

wallpaper_dir=$HOME/.rice/wallpapers

wallpaper_file=$(find "$wallpaper_dir" -type f | shuf -n 1) \
&& echo "$wallpaper_file"
