<div align="center">
    <h1>Hypr-Dotfiles</h1>
    Моя собственная конфигурация для Hyprland на Arch Linux.
    <br>
</div>

___

# Заголовки
- [Установка](#установка)

## Установка
>[!NOTE]
>Установку рекомендуется делать на чистом ОС как и Hyprland, если вы уже ранее редактировали свой, то лучше стоит сделать бэкап своих конфигураций(то есть, полностью сделать сохранение папки `.config/`) если что-то может пойти не так.
- Установить мою конфигурацию можно командой: ```git clone https://github.com/ExtbhiteEAS/hypr-dotfiles.git && cd hypr-dotfiles && sh install.sh```
- Установить можно и руками:
    - Установите необходимые зависимости для корректной работы этой конфигурации: ```sudo pacman -S base-devel git nodejs npm waybar waypaper wlogout zsh otf-font-awesome ttf-nunito thunar rofi nwg-look fastfetch cava btop 7z swww kitty nvidia-open-dkms egl-wayland nvidia-utils```;
        - Также и пользовательские через AUR(`yay`): ```yay -S gpu-screen-recorder hyprpicker hyprshot```;
    - Скачать файлы из репозиториию;
    - Вставить файлы из папки `config/` в вашу папку с конфигурацией: `.config/`. И всё.