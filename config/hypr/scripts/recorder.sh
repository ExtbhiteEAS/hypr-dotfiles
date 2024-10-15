#!/bin/zsh

pidof -q gpu-screen-recorder && exit 0
video="$HOME/Видео/$(date +"Video_%Y-%m-%d_%H-%M-%S.mp4")"
gpu-screen-recorder -w screen -f 144 -a "$(pactl get-default-sink).monitor" -o "$video"