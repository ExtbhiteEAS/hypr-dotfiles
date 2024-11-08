#!/bin/sh

# Значения
LIBRARIES='base-devel git nodejs npm waybar waypaper wlogout zsh otf-font-awesome ttf-nunito thunar firefox wofi nwg-look steam fastfetch cava btop 7z swww kitty'
NVIDIA_LIBRARIES='nvidia-open-dkms egl-wayland nvidia-utils'
YAY_LIBRARIES='gpu-screen-recorder hyprpicker-git hyprshot'

discordInstall() {
    echo "[ACTION] Теперь установим Discord, который у нас будет модифицированным. Выберите, какой хотите, разница лишь в количестве плагина и функционала."
    select ve in "Vencord" "Equicord"; do
        case $ve in
            Vencord ) vencordInstall; break;;
            Equicord ) equicordInstall; break;;
        esac
    done
}

vencordInstall() {
    git clone $VENCORD_URL
    cd $VENCORD_DIRECTORY && sudo npm i -g pnpm && pnpm i
    cd src/ && mkdir userplugins
    cd userplugins/ && git clone $FAKEPROFILE_URL && pnpm build
    customClients
    cd ~/
}

equicordInstall() {
    git clone $EQUICORD_URL
    cd $EQUICORD_DIRECTORY && sudo npm i -g pnpm && pnpm i
    cd src/ && mkdir userplugins
    cd userplugins/ && git clone $FAKEPROFILE_URL && pnpm build
    customClients
    cd ~/
}

main() {
    clear
    echo "[INFO] Установка основных библиотек..."
    sudo pacman -S $LIBRARIES

    echo "[INFO] Установка yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si && cd ~/
    
    echo "[INFO] Установка библиотек из AUR..."
    yay -S $YAY_LIBRARIES

    while true; do
        read -p "[ACTION] Ваш компьютер имеет видеокарту NVIDIA? [Y/N]: " yn
        case $yn in
            [Yy]* ) echo "[INFO] Идёт установка библиотек для NVIDIA..." && sudo pacman -S $NVIDIA_LIBRARIES; break;;
            [Nn]* ) echo "[INFO] Простите, но мой dotfile не основан на видеокарте AMD, так как я вообще его делал под видеокарту NVIDIA, которая стоит у меня на ноутбуке. Если у вас будут графические проблемы, то простите - я ничего пока не смогу делать."; break;;
            * ) echo "Ответьте: да или нет?";;
        esac
    done

    echo "[INFO] Дальше, теперь нам нужно подредактировать файл /etc/mkinitcpio.conf под NVIDIA."
    echo "[INFO] Где массив MODULES: нам нужно указать эти значение в скобках - nvidia nvidia_modeset nvidia_uvm nvidia_drm"
    echo "[INFO] Далее будет создан файл по пути /etc/modprobe.d/nvidia.conf только после редактирование, но там нужно будет указать: options nvidia_drm modeset=1 fbdev=1"
    while true; do
        read -p "[ACTION] Готовы вы редактировать файлы? [Y/N]: " yn
        case $yn in
            [Yy]* ) sudo nano /etc/mkinitcpio.conf && sudo nano /etc/modprobe.d/nvidia.conf && sudo mkinitcpio -P; break;;
            [Nn]* ) echo "[INFO] Тогда откройте эту ссылку в браузере и копируйте оттуда значение и вставляйте куда нужно: https://wiki.hyprland.org/Nvidia/#drm-kernel-mode-setting";;
            * ) echo "Ответьте: да или нет?";;
        esac
    done

    discordInstall
}

echo "[INFO] Прежде чем начать установку этого dotfile: сделайте сохранение(бэкап) своих старых конфигураций и прочее, если возникнут проблемы с установкой - нужно это делать с чистой ОС."
echo "[INFO] Сам dotfile для Hyprland был сделан на Arch Linux. Так что, если у Вы пытаетесь установить этот dotfile и встретите ошибку связанный с pacman - не стоит."
echo "[INFO] Также, убедитесь что locale стоит на ru_RU.UTF-8 UTF-8, ибо есть пути папок, которые будут на русском благодаря Thunar. Изучить об этом можно тут: https://wiki.archlinux.org/title/Locale_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)"
while true; do
    read -p "[ACTION] Вы уверены, то что хотите установить этот dotfile? [Y/N]: " yn
    case $yn in
        [Yy]* ) main; break;;
        [Nn]* ) echo "[INFO] Тогда, до свидание. :)"; break;;
        * ) echo "Ответьте: да или нет?";;
    esac
done