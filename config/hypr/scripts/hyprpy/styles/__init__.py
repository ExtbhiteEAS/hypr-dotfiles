import json
import json5
import os

from styles import metadata

def get_settings():
    return {
        "zenProfile": "sota08zo.Default (alpha\\)"
    }

class ThemeChanger:
    def __init__(self, var_style: str) -> None:
        self.var_style = var_style
        self.waybar_style_border = '2px solid' # Меняется только тут.
        self.config_path = '~/.config'

    def get_theme_data(self):
        with open(os.path.expanduser(f'~/.styles/{self.var_style}/theme.json'), 'r') as style_data:
            return json.load(style_data)
        
    def dunst_change(self):
        with open(os.path.expanduser(f'{self.config_path}/dunst/dunstrc'), 'r+') as dunst_file:
            data = dunst_file.readlines()

            dunst_file.seek(0)
            dunst_file.truncate()

            i = 0

            for lines in data:
                i += 1
                lines_new = lines.replace('\n', '')
                new_color = self.get_theme_data()['dunst']['frame_color']

                if '    frame_color' in lines_new:
                    if '    frame_color = "#fab387"' in lines_new:
                        pass
                    else:
                        lines = lines.replace(
                            f'{lines_new}\n',
                            f'    frame_color = "{new_color}"\n'
                        )
                        
                dunst_file.write(lines)
    
    def extra_var_change(self):
        with open(os.path.expanduser(f'{self.config_path}/hypr/extra/variables.conf'), 'r+') as var_file:
            data = var_file.readlines()

            var_file.seek(0)
            var_file.truncate()

            i = 0

            for lines in data:
                i += 1
                lines_new = lines.replace('\n', '')
                new_color = self.get_theme_data()['extra/variables']['active_border']

                if '    col.active_border' in lines_new:
                    lines = lines.replace(
                        f'{lines_new}\n',
                        f'    col.active_border = {new_color}\n'
                    )
                        
                var_file.write(lines)

    def fastfetch_change(self):
        with open(os.path.expanduser(f'{self.config_path}/fastfetch/config.jsonc'), 'r') as ff_file:
            data = json5.load(ff_file)

        data['logo']['source'] = self.get_theme_data()['fastfetch']
        
        with open(os.path.expanduser(f'{self.config_path}/fastfetch/config.jsonc'), 'w') as ff_file:
            json5.dump(
                data,
                ff_file,
                indent = 4,
                ensure_ascii = False,
                quote_keys = True,
                trailing_commas = False
            )

    def rofi_change(self):
        with open(os.path.expanduser(f'{self.config_path}/rofi/theme.rasi'), 'r+') as rofi_file:
            data = rofi_file.readlines()

            rofi_file.seek(0)
            rofi_file.truncate()

            i = 0

            for lines in data:
                i += 1
                lines_new = lines.replace('\n', '')
                new_color = self.get_theme_data()['rofi']

                if '   border-col:' in lines_new:
                    lines = lines.replace(
                        f'{lines_new}\n',
                        f'    border-col: {new_color};\n'
                    )

                if '   blue:' in lines_new:
                    lines = lines.replace(
                        f'{lines_new}\n',
                        f'    blue: {new_color};\n'
                    )

                rofi_file.write(lines)
    
    def waybar_change(self):
        with open(os.path.expanduser(f'{self.config_path}/waybar/style.css'), 'r+') as waybar_file:
            data = waybar_file.readlines()

            waybar_file.seek(0)
            waybar_file.truncate()

            i = 0

            for lines in data:
                i += 1
                lines_new = lines.replace('\n', '')
                new_color = self.get_theme_data()['waybar']

                if '    border:' in lines_new:
                    lines = lines.replace(
                        f'{lines_new}\n',
                        f'    border: {self.waybar_style_border} {new_color};\n'
                    )
                        
                waybar_file.write(lines)
    
    def wlogout_change(self):
        with open(os.path.expanduser(f'{self.config_path}/wlogout/style.css'), 'r+') as wlogout_file:
            data = wlogout_file.readlines()

            wlogout_file.seek(0)
            wlogout_file.truncate()

            i = 0
            f = 0

            for lines in data:
                i += 1
                lines_new = lines.replace('\n', '')
                new_colors = [
                    self.get_theme_data()['wlogout']['focus-active'],
                    self.get_theme_data()['wlogout']['hover']
                ]

                if '    background-color:' in lines_new:
                    if '    background-color: rgba(12, 12, 12, 0.764);' in lines_new:
                        pass
                    elif '    background-color: #11111b;' in lines_new:
                        pass
                    else:
                        lines = lines.replace(
                            f'{lines_new}\n',
                            f'    background-color: {new_colors[f]};\n'
                        )
                        f += 1

                if '    border-color:' in lines_new:
                    if '    border-color: #000000;' in lines_new:
                        pass
                    else:
                        lines = lines.replace(
                            f'{lines_new}\n',
                            f'    border-color: {new_colors[1]};\n'
                        )
                        
                wlogout_file.write(lines)
    
    def hyprlock_change(self):
        with open(os.path.expanduser(f'{self.config_path}/hypr/hyprlock.conf'), 'r+') as hyprlock_file:
            data = hyprlock_file.readlines()

            hyprlock_file.seek(0)
            hyprlock_file.truncate()

            i = 0
            styles = [
                'border_color',
                'outer_color',
                'check_color'
            ]

            for lines in data:
                i += 1
                lines_new = lines.replace('\n', '')
                new_color = self.get_theme_data()['hyprlock']

                for style in styles:
                    if f'    {style}' in lines_new:
                        lines = lines.replace(
                            f'{lines_new}\n',
                            f'    {style} = {new_color}\n'
                        )
                        
                hyprlock_file.write(lines)

    def change(self):
        self.dunst_change()
        self.extra_var_change()
        self.fastfetch_change()
        self.rofi_change()
        self.waybar_change()
        self.wlogout_change()
        self.hyprlock_change()

        os.system(f"swww img ~/Изображения/wallpapers/{self.var_style}.jpg --transition-fps 144 --transition-type grow --transition-pos \"$(hyprctl cursorpos)\" --transition-duration 3")
        os.system("killall dunst && killall -SIGUSR2 waybar")
        os.system(f"notify-send -t 1500 \"Настройки\" \"Тема была изменена на: {metadata.style_names[f'{self.var_style}']}\"")