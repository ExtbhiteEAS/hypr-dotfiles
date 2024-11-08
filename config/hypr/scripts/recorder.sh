#!/bin/zsh

video="$HOME/Видео/$(date +"Video_%Y-%m-%d_%H-%M-%S.mp4")"

if pidof gpu-screen-recorder; then
    killall -SIGINT -q gpu-screen-recorder
    notify-send -t 1500 "Запись остановлена" "Видео сохранено по пути: $video"
else
    notify-send -t 1500 "Запись начата" 'Будет сохранено по пути: '$video''
    gpu-screen-recorder -w screen -f 144 -a "$(pactl get-default-sink).monitor" -q ultra -o "$video"
fi