#! /bin/sh
#
# arch.sh
#
# Sets up Arch Linux

BRED='\033[1;31m'       # Bold Red
BWHITE='\033[1;37m'     # Bold White
UWHITE='\033[4;37m'     # Underlined White
NC='\033[0m'            # No Color

# Function to annotate in bold what is happening
function boldecho {
    echo -e "${BWHITE}$1${NC}"
}

function uecho {
    echo -e "${UWHITE}$1${NC}"
}

boldecho "================= Sumner's Arch Linux setup script =================="
echo

if [[ "$(whoami)" == "root" ]]; then
    echo "ERROR: Cannot run as root. Please create a user, and run as that user."
    echo "Exiting..."
    exit
fi

boldecho "--------------------------- Create TMPFS's --------------------------"
echo -en "${BRED}"
echo "This setup script can convert ~/tmp, ~/.cache, and"
echo "/var/cache/pacman/pkg into tmpfs's."
echo ".-------------------------------------------------------------------."
echo "|           THIS IS A DESTRUCTIVE OPERATION. EVERYTHING IN          |"
echo "|             ~/tmp, ~/.cache, and /var/cache/pacman/pkg            |"
echo "|                          WILL BE DELETED                          |"
echo "'-------------------------------------------------------------------'"
echo -en "${NC}"

read -p "Make ~/tmp, ~/.cache, and /var/cache/pacman/pkg into tmpfs's? (y/N) " tmpfs </dev/tty
case "$tmpfs" in
    y|Y|yes|Yes|YES )
        boldecho "Nuking and recreating directories"
        # Nuke and recreate directories
        sudo rm -rf $HOME/tmp $HOME/.cache /var/cache/pacman/pkg
        sudo mkdir -p $HOME/tmp $HOME/.cache /var/cache/pacman/pkg

        # Append to fstab
        echo "
# tmpfs for ~/tmp, ~/.cache, /var/cache/pacman/pkg
tmpfs			/home/sumner/tmp	tmpfs	rw,nodev,nosuid,size=32G	0	0
tmpfs			/home/sumner/.cache	tmpfs	rw,nodev,nosuid,size=32G	0	0
tmpfs			/var/cache/pacman/pkg	tmpfs	rw,nodev,nosuid,size=32G	0	0
        " | sudo tee -a /etc/fstab

        # Mount
        sudo mount -a
        ;;
    *) echo "Skipping..." ;;
esac

echo
boldecho "--------------------------- git and Yay --------------------------"
echo "The rest of this script requires that git and Yay are installed."
read -p "Proceed to install git and Yay? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing git..."
        sudo pacman -S git

        uecho "Installing Yay..."
        pushd $HOME/tmp
            git clone https://aur.archlinux.org/package-query.git
            pushd package-query
                makepkg -si
            popd

            git clone https://aur.archlinux.org/yay.git
            pushd yay
                makepkg -si
            popd
        popd
        ;;
    *) echo "Skipping..." ;;
esac

echo
boldecho "------------------------------- system ------------------------------"
read -p "Install core system tools? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S coreutils cups cups-pdf dhcpcd diffutils exfat-utils dnsmasq
        ;;
    *) echo "Skipping..." ;;
esac

echo
read -p "Install EFI tools? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S efibootmgr
        ;;
    *) echo "Skipping..." ;;
esac

echo
read -p "Install Nvidia drivers? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S nvidia nvidia-settings nvidia-utils
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install Broadcom drivers? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S broadcom-wl-dkms
        ;;
    *) echo "Skipping..." ;;
esac

echo
read -p "Install network manager? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S networkmanager networkmanager-openvpn
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install FaceTime camera drivers? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S bcwc-pcie-git
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install audio management? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S pulseaudio-alsa pulseaudio-bluetooth alsa-utils
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install fonts? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S ttf-font-awesome-4 ttf-inconsolata ttf-iosevka \
            ttf-iosevka-term ttf-liberation ttf-linux-libertine ttf-ms-fonts \
            ttf-opensans noto-fonts noto-fonts-emoji otf-font-awesome-4
        ;;
    *) continue
esac

read -p "Install Bluetooth and management tools? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S blueman bluez bluez-utils
        ;;
    *) continue
esac

echo
boldecho "------------------------------- shell -------------------------------"
read -p "Install zsh and dependencies? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-you-should-use
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install email tools? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S mutt msmpt offlineimap pass offlinemsmtp
        ;;
    *) continue
esac

read -p "Install SSH/GPG tools? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S openssh
        ;;
    *) continue
esac

read -p "Install command line editors? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S vi vim neovim
        ;;
    *) continue
esac

read -p "Install other command line essentials? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S ranger w3m wget openssl zip youtube-dl unzip tmux which sed \
            aspell-en aspell-es fd exa elinks ffmpeg sloccount \
            ffmpegthumbnailer fzf grep gzip hub lynx pandoc less ripgrep screen \
            screenfetch speedtest-cli
        ;;
    *) continue
esac

echo
boldecho "-------------------- Xorg and GUI Applications ----------------------"
read -p "Install Xorg? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S xorg xinit-xsession
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install i3wm and essentials? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S i3 rofi-dmenu adapta-gtk-theme clipmenu compton dunst feh \
            imagemagick lxappearance menu-calc termite passmenu redshift \
            scrot xbindkeys menu-calc
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install dropbox and dropbox-cli? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S dropbox dropbox-cli
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install nextcloud? (Y/n) " install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )  # Proceed with install
        uecho "Installing..."
        yay -S nextcloud-client
        ;;
    *) echo "Skipping..." ;;
esac

read -p "Install chat applications? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S riot-desktop wire-desktop-bin slack-desktop signal-desktop-bin
        ;;
    *) continue
esac

read -p "Install other GUI applications? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S spotify firefox-nightly mpv gimp inkscape baobab zathura \
            guvcview kdeconnect klavaro libreoffice-fresh lxappearance \
            simple-scan thunar thunar-archive-plugin thunar-media-tags-plugin \
            thunar-volman
        ;;
    *) continue
esac
echo ""

read -p "Install Developer tools? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S llvm clang python python2 cmake vale-bin boost brittany \
            docker eslint flake8 fzf gcc ghc gource idris make \
            javascript-typescript-langserver kattis-problemtools npm \
            python-language-server python-neovim python-virtualenv \
            python-virtualenvwrapper sfml \
            vscode-css-languageserver-bin vscode-html-languageserver-bin
        ;;
    *) continue
esac
echo ""

read -p "Install LaTeX? (Y/n)" install </dev/tty
case "$install" in
    ""|y|Y|yes|Yes|YES )
        yay -S texlive-most
        ;;
    *) continue
esac
echo ""
