#!/usr/bin/sh

# THE FUNCTION TO CALL
# TYPE="mojave_dynamic"
# TYPE="catalina_dynamic"
TYPE="random_bg"

FILE="$HOME/tmp/bg_list.txt"
BG_DIRS=(
    $HOME/Pictures/wallpapers/elementary
    $HOME/Pictures/wallpapers/linux
    $HOME/Pictures/wallpapers/pexels
    $HOME/Pictures/wallpapers/star-wars
    $HOME/Pictures/wallpapers/system76
)
TMP_WP="$HOME/tmp/wallpaper.jpg"

pgrep sway > /dev/null
IS_SWAY=$?

mojave_dynamic() {
    h=$(date '+%H')
    m=$(date '+%M')
    echo "Setting wallpaper for $h:$m"

    # Chop off leading zero.
    [[ "${m:0:1}" == "0" ]] && m="${m:1}"

    case $h in
        23|00|01|02)
            if [[ "$h" != "02" ]]; then skip_transition=1; fi
            wp_num=15
            ;;
        03|04)
            if [[ "$h" != "04" ]]; then skip_transition=1; fi
            wp_num=16
            wp_next=1
            ;;
        05) wp_num=1;;
        06) wp_num=2;;
        07) wp_num=3;;
        08) wp_num=4;;
        09) wp_num=5;;
        10) wp_num=6;;
        11|12)
            if [[ "$h" != "11" ]]; then skip_transition=1; fi
            wp_num=7
            ;;
        13|14)
            if [[ "$h" != "14" ]]; then skip_transition=1; fi
            wp_num=8
            ;;
        15) wp_num=9;;
        16) wp_num=10;;
        17) wp_num=11;;
        18) wp_num=12;;
        19) wp_num=13;;
        20|21|22)
            if [[ "$h" != "22" ]]; then skip_transition=1; fi
            wp_num=14
            ;;
    esac

    # Determine amount to transition
    if [ -z $wp_next ]; then wp_next=$((wp_num + 1)); fi
    if [ $(( $m < 20 )) == 1 ]; then
        wp_transition_level=0
    elif [ $(( $m < 30 )) == 1 ]; then
        wp_transition_level=20
    elif [ $(( $m < 40 )) == 1 ]; then
        wp_transition_level=40
    elif [ $(( $m < 50 )) == 1 ]; then
        wp_transition_level=60
    else
        wp_transition_level=80
    fi

    echo "WP: $wp_num"
    echo "Next: $wp_next"
    echo "TS: $wp_transition_level"
    echo "Skip transition: $skip_transition"

    # Wallpaper Directory
    dyn_wp_dir="$HOME/Pictures/wallpapers/Apple/mojave-background"

    if [[ $skip_transition == 1 ]]; then
        TMP_WP="$dyn_wp_dir/mojave_dynamic_$wp_num.jpeg"
    else
        # Composite the picture.
        composite -dissolve $wp_transition_level \
                  -gravity Center \
                  "$dyn_wp_dir/mojave_dynamic_$wp_next.jpeg" \
                  "$dyn_wp_dir/mojave_dynamic_$wp_num.jpeg" \
                  -alpha Set \
                  $TMP_WP
    fi

    feh --bg-fill "$TMP_WP"
}

catalina_dynamic() {
    h=$(date '+%H')
    m=$(date '+%M')
    echo "Setting wallpaper for $h:$m"

    # Chop off leading zero.
    [[ "${m:0:1}" == "0" ]] && m="${m:1}"
    wp_names=("0000" "0300" "0600" "0900" "1200" "1500" "1800" "2100")

    case $h in
        00|01|02)
            if [[ "$h" != "02" ]]; then skip_transition=1; fi
            wp_num=0
            ;;
        03|04|05)
            if [[ "$h" != "05" ]]; then skip_transition=1; fi
            wp_num=1
            ;;
        06|07|08)
            if [[ "$h" != "08" ]]; then skip_transition=1; fi
            wp_num=2
            ;;
        09|10|11)
            if [[ "$h" != "11" ]]; then skip_transition=1; fi
            wp_num=3
            ;;
        12|13|14)
            if [[ "$h" != "14" ]]; then skip_transition=1; fi
            wp_num=4
            ;;
        15|16|17)
            if [[ "$h" != "17" ]]; then skip_transition=1; fi
            wp_num=5
            ;;
        18|19|20)
            if [[ "$h" != "20" ]]; then skip_transition=1; fi
            wp_num=6
            ;;
        21|22|23)
            if [[ "$h" != "23" ]]; then skip_transition=1; fi
            wp_num=7
            wp_next=0
            ;;
    esac

    # Determine amount to transition
    if [ -z $wp_next ]; then wp_next=$((wp_num + 1)); fi
    wp_transition_level=$(echo "$m / 60 * 100" | bc -l)

    echo "WP: $wp_num"
    echo "Next: $wp_next"
    echo "TS: $wp_transition_level"
    echo "Skip transition: $skip_transition"

    # Wallpaper Directory
    dyn_wp_dir="$HOME/Pictures/wallpapers/Apple/catalina-dynamic"

    if [[ $skip_transition == 1 ]]; then
        TMP_WP="$dyn_wp_dir/catalina_dynamic-${wp_names[wp_num]}.jpg"
    else
        # Composite the picture.
        composite -dissolve $wp_transition_level \
                  -gravity Center \
                  "$dyn_wp_dir/catalina_dynamic-${wp_names[wp_next]}.jpg" \
                  "$dyn_wp_dir/catalina_dynamic-${wp_names[wp_num]}.jpg" \
                  -alpha Set \
                  $TMP_WP
    fi

    feh --bg-fill "$TMP_WP"
}

die () {
    echo >&2 "$@"
    exit 1
}

load_list() {
    # Append all of the wallpaper file names to bg_list.txt
    for bg_dir in "${BG_DIRS[@]}"; do
        find -L $bg_dir -type f | while read bg; do
            echo $bg >> "$FILE"
        done
    done
    cat $FILE | shuf | tee $FILE
}

random_bg () {
    # Check args
    for bg_dir in "${BG_DIRS[@]}"; do
        [[ -d "$bg_dir" ]] || [[ -f "$bg_dir" ]] || die "$bg_dir is not a file or directory"
    done

    # Add shuffle backgrounds into bg_list.txt if necessary
    touch "$FILE"

    # Remove the used image from the top of the file
    tail -n +3 $FILE > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"

    [[ $(wc -l <"$FILE") == 0 ]] && load_list $BG_DIRS

    # Set the background
    f1=$(head -1 $FILE)
    f2=$(sed "2q;d" $FILE)
    echo "Setting $f1 $f2 as backgrounds"
    feh --bg-fill $f1 $f2

    if [[ "$2" == "--generate-lock-image" ]]; then
        # Resize the lock image
        convert "$(head -1 "$FILE")" -blur 30x15 -resize 2880x1800^ \
            -gravity center -extent 2880x1800 $HOME/tmp/screen_locked.tmp.png
        mv $HOME/tmp/screen_locked.tmp.png $HOME/tmp/screen_locked.png
    fi
}

$TYPE
