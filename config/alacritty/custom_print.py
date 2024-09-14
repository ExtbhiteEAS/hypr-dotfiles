from dataclasses import fields
from catppuccin import PALETTE
from colorama import init, Style

init() # Это заставляет терминал видеть цвета.

# https://unix.stackexchange.com/a/781105
SET_FOREGROUND_ESCAPE = "\033[38;2;{r};{g};{b}m"
SET_BACKGROUND_ESCAPE = "\033[48;2;{r};{g};{b}m"

def set_foreground(r, g, b):
    return SET_FOREGROUND_ESCAPE.format(r=r, g=g, b=b)

def set_background(r, g, b):
    return SET_BACKGROUND_ESCAPE.format(r=r, g=g, b=b)

# https://stackoverflow.com/a/60630148
def hex_to_rgb(hex: str):
    h = hex.lstrip('#')
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

flavor = PALETTE.latte

def get_colors():
    for field in fields(flavor.colors):
        color = getattr(flavor.colors, field.name)
        rgb = hex_to_rgb(str(color.hex))
        set_background(*rgb); print(f"{field.name}: {color.hex}{Style.RESET_ALL}")

RED = set_background(*hex_to_rgb(flavor.colors.red.hex))
BLUE = set_background(*hex_to_rgb(flavor.colors.blue.hex))
TEXT = set_background(*hex_to_rgb(flavor.colors.base.hex))
RESET = Style.RESET_ALL

# Ширина каждого текста 43 пробела.
logo = f'''
   {TEXT}                                           {RESET}
   {TEXT}                                           {RESET}
   {TEXT}                                           {RESET}
   {TEXT}                                           {RESET}
   {BLUE}                                           {RESET}
   {BLUE}                                           {RESET}
   {BLUE}                                           {RESET}
   {BLUE}                                           {RESET}
   {RED}                                           {RESET}
   {RED}                                           {RESET}
   {RED}                                           {RESET}
   {RED}                                           {RESET}
'''

print(logo)