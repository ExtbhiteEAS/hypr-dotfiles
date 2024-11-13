#!/bin/sh

# Значения
LIBRARIES='base-devel git waybar zsh otf-font-awesome ttf-nunito ttf-jetbrains-mono-nerd thunar rofi nwg-look fastfetch cava btop 7z swww kitty'
NVIDIA_LIBRARIES='nvidia-open-dkms egl-wayland nvidia-utils' # Тут только для новых, для старых я не знаю.
YAY_LIBRARIES='wlogout waypaper gpu-screen-recorder hyprpicker hyprshot zen-browser-bin'

discordInstall() {
    echo "[INFO] Устанавливаем Node.JS v20.18.0 LTS..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    nvm install 20

    python3 ~/hypr-dotfiles/install/custom_discord.py
}

nvidiaConfiguring () {
    echo "[INFO] Дальше, теперь нам нужно подредактировать файл /etc/mkinitcpio.conf под NVIDIA."
    echo "[INFO] Где массив MODULES: нам нужно указать эти значение в скобках - nvidia nvidia_modeset nvidia_uvm nvidia_drm"
    echo "[INFO] Далее будет создан файл по пути /etc/modprobe.d/nvidia.conf только после редактирование, но там нужно будет указать: options nvidia_drm modeset=1 fbdev=1"
    while true; do
        read -p "[ACTION] Готовы вы редактировать файлы? [Y/N]: " yn
        case $yn in
            [Yy]* ) sudo nano /etc/mkinitcpio.conf && sudo nano /etc/modprobe.d/nvidia.conf && sudo mkinitcpio -P; break;;
            [Nn]* ) echo "[INFO] Тогда откройте эту ссылку в браузере, копируйте оттуда значение и вставляйте куда нужно: https://wiki.hyprland.org/Nvidia/#drm-kernel-mode-setting";;
            * ) echo "Ответьте: да или нет?";;
        esac
    done

    while true; do
        echo "[INFO] Про .config/hypr/extra/environment.conf стоит прочитать в README."
        read -p "[ACTION] Вы готовы редактировать файл .config/hypr/extra/environment.conf и раскомментировать необходимые для вашей карты значение? [Y/N]: " yn
        case $yn in
            [Yy]* ) nano $HOME/.config/hypr/extra/environment.conf; break;;
            [Nn]* ) echo "[WARN] Как уже было сказано, то что Hyprland не поддерживает оборудование от NVIDIA. Потому стоит прочитать README."; break;;
            * ) echo "Ответьте: да или нет?";;
        esac
    done
}

main() {
    clear
    echo "[INFO] Установка основных библиотек..."
    sudo pacman -S $LIBRARIES

    echo "[INFO] Установка yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si && cd ..
    
    echo "[INFO] Установка библиотек из AUR..."
    yay -S $YAY_LIBRARIES

    while true; do
        read -p "[ACTION] Ваш компьютер имеет видеокарту NVIDIA? [Y/N]: " yn
        case $yn in
            [Yy]* ) echo "[INFO] Идёт установка библиотек для NVIDIA..." && sudo pacman -S $NVIDIA_LIBRARIES && nvidiaConfiguring; break;;
            [Nn]* ) echo "[INFO] Простите, но моя конфигурация не основана на видеокарте AMD, так как я вообще его делал под видеокарту NVIDIA, которая стоит у меня на ноутбуке. Если у вас будут графические проблемы, то простите - я ничего пока не смогу делать."; break;;
            * ) echo "Ответьте: да или нет?";;
        esac
    done

    while true; do
        read -p "[ACTION] Желаете ли установить модифицированные клиенты Discord'a? [Y/N]: " yn
        echo "[INFO] P.S У меня Equibop заточен под горячие клавиши как: Super + Shift + E, но его можно убрать при своём усмотрении."
        case $yn in
            [Yy]* ) discordInstall; break;;
            [Nn]* ) echo "[INFO] Установка модифицированного клиента Discord - пропущен."; break;;
        esac
    done

    echo "[INFO] Копируем файлы конфигурации и вставляем в ваши."
    cp -r config/* $HOME/.config/

    echo "[INFO] Установка завершена!"
}

echo "[INFO] Прежде чем начать установку данной конфигурации Hyprland, прочитайте файл README.md. Так как в нём может быть полезная информация. Спасибо."
while true; do
    read -p "[ACTION] Вы уверены, то что хотите установить этот dotfile? [Y/N]: " yn
    case $yn in
        [Yy]* ) main; break;;
        [Nn]* ) echo "[INFO] Тогда, до свидание. :)"; break;;
        * ) echo "Ответьте: да или нет?";;
    esac
done
