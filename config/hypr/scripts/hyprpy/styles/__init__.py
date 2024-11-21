import os

class ThemeChanger:
    def __init__(self) -> None:
        self.config_path = '~/.config'
        self.hyprpy_path = f'{self.config_path}/hypr/scripts/hyprpy'
    
    def waypaper(self, path: str):
        fixed_path = os.path.expanduser(path)
        file_name = os.path.basename(fixed_path)
        
        os.system(f"sh {self.hyprpy_path}/styles/style_change.sh --path {fixed_path} --filename {file_name}")