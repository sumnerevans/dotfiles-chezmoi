#! /bin/sh
#
# os-x.sh
#
# Sets up OS X
#
# Requires Xcode to be installed

# Make ~/tmp folder
mkdir -p $HOME/tmp

# Usage brew_install item force
function brew_install() {
    # If force is true or if the program is not installed, install it
    if [[ $2 == true || ( ! $(which $1) && ! $(brew list | grep $1) )]]; then
        if [[ $2 == true ]]; then
            echo "Forcing installation of $1"
        fi

        brew install $1
    else
        echo "$1 is already installed"
    fi
}

function brew_cask_install() {
    apps=$(ls /Applications | sed 's/ //g')
    name=$(echo $2 | sed 's/ //g')

    if [[ $3 == true || ( ! $(echo $apps | grep -iw $1.app) && ! $(echo $apps | grep -iw $name.app) ) ]]; then
        if  [[ $3 == true ]]; then
            echo "Forcing installation of $1"
        fi

        brew cask install $1
    else
        echo "$1 is already installed"
    fi
}

function mas_install() {
    apps=$(mas list | sed 's/ //g')
    name=$(echo $1 | sed 's/ //g')

    if [[ ! $(echo $apps | grep $name) ]]; then
        mas install $(mas search $1 | awk 'NR == 1 {print $1}')
    else
        echo "$1 is already installed"
    fi
}

function npm_install() {
    if [[ ! $(npm list -g $1) ]]; then
        npm install -g $1
    else
        echo "$1 is already installed"
    fi
}

echo ""
echo "===== Installing Homebrew ====="
if [[ ! $(which brew) ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap caskroom/cask

echo ""
echo "===== Installing Dropbox ====="
if [[ ! -d "/Applications/Dropbox.app" ]]; then
    brew cask install dropbox
else
    echo "Dropbox already installed"
fi

read -p "Press [enter] once you have finished setting up Dropbox"

echo ""
echo "===== Installing Command Line Essentials ====="
brew_install vim true
brew_install w3m
brew_install wget
brew_install zsh
brew_install mutt
brew_install openssl
brew_install readline
brew_install xz
brew_install mas

if [[ ! $(mas account) ]]; then
    echo "Setting up Mac App Store CLI"
    read -p "Enter Apple ID:" appleid
    mas signin "$appleid"
fi

echo ""
echo "===== Installing Essential Programs ====="
brew_cask_install smcfancontrol
brew_cask_install iterm2 "iTerm"
brew_cask_install seil
brew_cask_install firefox
brew_cask_install google-chrome "Google Chrome"
brew_cask_install google-drive "Google Drive"
brew_cask_install crashplan
brew_cask_install flux

# Install Mac App Store applications
mas_install Slack
mas_install Unclutter
mas_install "The Unarchiver"
mas_install Magnet
mas_install "Memory Clean"
mas_install "Be Focused"
mas_install Pixelmator
mas_install Byword
mas_install Notability
mas_install DaisyDisk

echo ""
echo "===== Installing Developer Tools ====="
brew_install python3
brew_install astyle
brew_install node
brew_install llvm
brew_install clang
brew_install cmake

brew_cask_install skype
brew_cask_install slack
brew_cask_install sublime-text "Sublime Text"
brew_cask_install intellij-idea "IntelliJ IDEA CE"
brew_cask_install atom

npm_install js-beautify

echo ""
echo "===== Installing non-critical Programs ====="
brew_cask_install spotify
brew_cask_install vlc
brew_cask_install gimp
brew_cask_install google-earth "Google Earth"
brew_cask_install jing
brew_cask_install mactex

mas_install Evernote
mas_install Wunderlist
