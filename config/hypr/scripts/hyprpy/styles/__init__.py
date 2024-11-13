import os

from styles import metadata

def get_settings():
    return {
        "zenProfile": "sota08zo.Default (alpha\\)"
    }

def ChangeTo(var_style: str):
    main_path = f"~/.config/hypr/scripts/hyprpy/styles/{var_style}"
    paths = [
        f"{main_path}/dunst/dunstrc",
        f"{main_path}/extra/variables.conf",
        f"{main_path}/fastfetch/config.jsonc",
        f"{main_path}/waybar/style.css",
        f"{main_path}/wlogout/style.css"
    ]

    paths_2 = [
        "~/.config/dunst/dunstrc",
        "~/.config/hypr/extra/variables.conf",
        "~/.config/fastfetch/config.jsonc",
        "~/.config/waybar/style.css",
        "~/.config/wlogout/style.css"
    ]
    
    for path, path_2 in zip(paths, paths_2):
        os.system(f"cp {path} {path_2}")

    os.system(f"cp {main_path}/hyprlock.conf ~/.config/hypr/hyprlock.conf")
    os.system(f"cp {main_path}/rofi/config.rasi ~/.config/rofi/config.rasi")
    #os.system(f"cp {main_path}/zen/userChrome.css ~/.zen/{get_settings()['zenProfile']}/chrome/userChrome.css")
    #os.system(f"cp {main_path}/zen/userContent.css ~/.zen/{get_settings()['zenProfile']}/chrome/userContent.css")
    
    os.system(f"swww img ~/Изображения/wallpapers/{var_style}.jpg --transition-fps 144 --transition-type grow --transition-pos \"$(hyprctl cursorpos)\" --transition-duration 3")
    os.system("killall dunst && killall -SIGUSR2 waybar")
    os.system(f"notify-send -t 1500 \"Настройки\" \"Тема была изменена на: {metadata.style_names[f'{var_style}']}\"")