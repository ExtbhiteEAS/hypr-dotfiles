#!/bin/sh

# Значения
LIBRARIES='base-devel git waybar zsh otf-font-awesome ttf-nunito ttf-jetbrains-mono-nerd rofi nwg-look fastfetch cava btop 7z swww kitty nemo nemo-fileroller nemo-preview xdg-desktop-portal-hyprland'
NVIDIA_LIBRARIES='nvidia-open-dkms egl-wayland nvidia-utils' # Тут только для новых, для старых я не знаю.
YAY_LIBRARIES='wlogout waypaper gpu-screen-recorder hyprpicker hyprshot hyprutils zen-browser-bin rofi-emoji-git'

source = install/other_functions.sh

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

    echo "[INFO] Установка библиотек для смены темы..."
    walInstall
    wpgInstall

    while true; do
        read -p "[ACTION] Ваш компьютер имеет видеокарту NVIDIA? [Y/N]: " yn
        case $yn in
            [Yy]* ) echo "[INFO] Идёт установка библиотек для NVIDIA..." && sudo pacman -S $NVIDIA_LIBRARIES && nvidiaConfiguring; break;;
            [Nn]* ) echo "[INFO] Если у вас карта от AMD - то тут уже ваша задача разобраться."; break;;
            * ) echo "Ответьте: да(y) или нет(n)?";;
        esac
    done

    while true; do
        read -p "[ACTION] Желаете ли установить модифицированный клиент Discord'a? [Y/N]: " yn
        echo "[INFO] P.S У меня Equibop заточен под горячие клавиши как: Super + Shift + E, но его можно убрать при своём усмотрении."
        case $yn in
            [Yy]* ) discordInstall; break;;
            [Nn]* ) echo "[INFO] Установка модифицированного клиента Discord - пропущен."; break;;
        esac
    done

    echo "[INFO] Копируем файлы конфигурации и вставляем в ваши."
    cp -r config/* $HOME/.config/
    mkdir $HOME/.themes/
    cp -r themes/* $HOME/.themes/

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
