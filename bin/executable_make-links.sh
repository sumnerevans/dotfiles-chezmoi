#! /bin/sh
#
# make-links.sh

echo "Creating symbolic links..."

if [[ ! -d "$HOME/Dropbox" ]]; then
    echo "NO DROPBOX FOLDER!!!"
    exit 1
fi

if [[ ! -f "sym-links.txt" ]]; then
    echo "NO SYMBOLIC LINK FILE LIST!!!"
    exit 2
fi

while read NAME
do
    echo ""
    echo "Checking $NAME..."

    if [[ ! -d "$HOME/$NAME" ]] && [[ ! -f "$HOME/$NAME" ]]; then
        echo "Linking $NAME"
        ln -s "$HOME/Dropbox/$NAME" "$HOME/$NAME"
    else
        echo "$NAME already exists"
    fi
done < sym-links.txt
