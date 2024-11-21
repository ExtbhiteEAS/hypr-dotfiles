while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--path) path="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

source ~/.config/hypr/scripts/hyprpy/venv/bin/activate
python3 ~/.config/hypr/scripts/hyprpy/waypaper_change.py --path $path