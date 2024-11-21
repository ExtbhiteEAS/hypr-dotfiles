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

# --break-system-packages указывается потому, что pip не даёт установить библиотеки/пакеты в систему Арча.
# Потому в этом случае, было необходимо указать этот аргумент в команде. Но почему не через pacman или yay?
# Ответ кроется в заготовке темы для Discord'a, ибо если скачать pywal через pacman - то когда будет выполняться команда, то это зараза выдаст ошибку в виде `TypeError: Color has no attrubite "red"`.
wpgInstall () {
    git clone https://github.com/deviantfero/wpgtk
    cd wpgtk
    pip3 install --break-system-packages .
    cd ..
}

walInstall () {
    git clone https://github.com/dylanaraps/pywal
    cd pywal
    pip3 install --break-system-packages .
    cd ..
}