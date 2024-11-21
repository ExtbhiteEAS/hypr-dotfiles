while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--path) path="$2"; shift ;;
        -f|--filename) filename="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

#echo "Path: $path"
#echo "Filename: $filename"

wal -i $path

wpg -a $path
wpg -s $filename && walogram -s
cp ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc
cp ~/.cache/wal/discord-pywal.css ~/.config/equibop/settings/quickCss.css

killall -SIGUSR2 waybar && killall dunst