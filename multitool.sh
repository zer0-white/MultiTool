#!/bin/bash

# create directory if it doesn't exist
if [ ! -d "git" ]; then
  mkdir -p "git"
fi
if [ ! -d "git/git-downloads" ]; then
  mkdir -p "git/git-downloads"
fi
if [ ! -d "git/git-list" ]; then
  mkdir -p "git/git-list"
fi
if [ ! -d "htb-vpn" ]; then
  mkdir -p "htb-vpn"
fi

# Load settings from file
SETTINGS_FILE="settings.conf"
if [ -f "$SETTINGS_FILE" ]; then
    downloads_dir=$(head -n 1 "$SETTINGS_FILE")
    network_interface=$(head -n 2 "$SETTINGS_FILE" | tail -n 1)
    nick_name=$(tail -n 1 "$SETTINGS_FILE")
else
    downloads_dir="$HOME/Downloads"
    network_interface="en0"
    nick_name="noob"
fi

# Load settings from file
load_settings

#Zer0 Art
art="
                      ##     ## ##     ## ##       ######## ####    ########  #######   #######  ##       
                      ###   ### ##     ## ##          ##     ##        ##    ##     ## ##     ## ##       
                      #### #### ##     ## ##          ##     ##        ##    ##     ## ##     ## ##       
                      ## ### ## ##     ## ##          ##     ##        ##    ##     ## ##     ## ##       
                      ##     ## ##     ## ##          ##     ##        ##    ##     ## ##     ## ##       
                      ##     ## ##     ## ##          ##     ##        ##    ##     ## ##     ## ##       
                      ##     ##  #######  ########    ##    ####       ##     #######   #######  ######## 
"

# Set the color to red
color="\e[31m"

# Print the padding and the art in the desired color
printf "%s${color}%s\e[0m\n" "" "$art"
##################################################################
###########################  COLORS  #############################
##################################################################
# Define color variables
YS="\e[1;33m"    # Yellow start
BS="\e[0;34m"    # Blue start
CE="\e[0m"       # Color end
RS="\e[1;31m"    # Red start
BLS="\e[0;30m"   # Black start
DGYS="\e[1;30m"  # Dark gray start
LBS="\e[1;34m"   # Light blue start
GNS="\e[0;32m"   # Green start
LGNS="\e[1;32m"  # Light green start
CYS="\e[0;36m"   # Cyan start
LCYS="\e[1;36m"  # Light cyan start
DRS="\e[0;31m"   # Light red start
PS="\e[0;35m"    # Purple start
##################################################################
#######################  FUNCTIONS-MENU  #########################
##################################################################
# Define function to display menu
function display_menu {
    echo -e "${YS}Select an option:${CE}"
    echo -e "${LBS}1.${CE} Display network interface information using ifconfig"
    echo -e "${LBS}2.${CE} Hack The Box"
    echo -e "${LBS}3.${CE} Git Installer"
    echo -e "${LBS}00.${CE} Settings"
    echo -e "${LBS}0.${CE} Exit"
    echo -ne "${CYS}Enter option number:${CE} "
}
# Define function to display HTB submenu
function htb_submenu {
    while true; do
        clear_screen
        echo -e "${YS}Hack The Box options:${CE}"
        echo -e "${LBS}1.${CE} Start HTB VPN connection"
        echo -e "${LBS}2.${CE} Configure HTB VPN connection"
        echo -e "${LBS}0.${CE} Return to main menu"
        echo -ne "${CYS}Enter option number:${CE} "
        read suboption
        case $suboption in
            1) start_htb_vpn ;;
            2) configure_htb_vpn ;;
            0) return ;;
            *) echo -e "${RS}Invalid option.${CE}" ;;
        esac
        echo -e "${CYS}Press Enter to continue.${CE}"
        read
    done
}
# Define function to display Settings submenu
function settings_submenu {
    while true; do
        clear_screen
        echo -e "${YS}Current settings:${CE}"
        echo -e "${LBS}Downloads directory:${CE} $downloads_dir"
        echo -e "${LBS}Network interface:${CE} $network_interface"
        echo -e "${LBS}Nick Name:${CE} $nick_name"
        echo -e ""
        echo -e "${YS}Settings options:${CE}"
        echo -e "${LBS}1.${CE} Configure Downloads Directory Path"
        echo -e "${LBS}2.${CE} Configure Network Interface"
        echo -e "${LBS}3.${CE} Configure Nick Name"
        echo -e "${LBS}0.${CE} Return to main menu"
        echo -ne "${CYS}Enter option number:${CE} "
        read suboption
        case $suboption in
            1) change_downloads_dir ;;
            2) change_network_interface ;;
            3) change_nick_name;;
            0) return ;;
            *) echo -e "${RS}Invalid option.${CE}" ;;
        esac
        echo -e "${CYS}Press Enter to continue.${CE}"
        read
    done
}
# Define function to display Git Installer submenu
function git_installer_submenu {
    while true; do
        clear_screen
        echo -e "${YS}Git Installer Options:${CE}"
        echo -e "${LBS}1.${CE} Install Popular Tools"
        echo -e "${LBS}2.${CE} Custom Install"
        echo -e "${LBS}3.${CE} Already Installed"
        echo -e "${LBS}0.${CE} Return to main menu"
        echo -ne "${CYS}Enter option number:${CE} "
        read suboption
        case $suboption in
            1) start_htb_vpn ;;
            2) custom_install_git ;;
            0) return ;;
            *) echo -e "${RS}Invalid option.${CE}" ;;
        esac
        echo -e "${CYS}Press Enter to continue.${CE}"
        read
    done
}
##################################################################
##########################  FUNCTIONS  ###########################
##################################################################
# Define function to clear screen
function clear_screen {
    clear
    printf "%s${color}%s\e[0m\n" "" "$art"
}
# Define function to display ifconfig output
function display_ifconfig {
    echo ""
    echo -e "${LCYS}ifconfig output:${CE}"
    ifconfig
}
function start_htb_vpn {
    echo ""
    echo -e "${LCYS}Starting Hack The Box VPN${CE}"
    sudo openvpn "htb-vpn/$nick_name.ovpn"
}
function configure_htb_vpn {
    echo ""
    echo -e "${LCYS}All OVPN Files In $downloads_dir:${CE} "
    ls -1 $downloads_dir/*.ovpn | grep -o '[^/]*$'
    echo -e "${LCYS}Enter The HTB VPN File Name:${CE} "
    read source_file
    sudo cp $downloads_dir/$source_file "htb-vpn/$nick_name.ovpn"
    echo "File copied successfully!"
}
# Define function to change downloads directory path
function change_downloads_dir {
    echo -e "${YS}Current downloads directory:${CE} $downloads_dir"
    echo -ne "${CYS}Enter new downloads directory path:${CE} "
    read new_downloads_dir
    if [ -d "$new_downloads_dir" ]; then
        echo "$new_downloads_dir" > settings.conf
        downloads_dir="$new_downloads_dir"
        echo -e "${LGNS}Downloads directory path changed to $downloads_dir.${CE}"
    else
        echo -e "${RS}Error: Directory not found.${CE}"
    fi
}

# Define function to change network interface
function change_network_interface {
    echo -e "${YS}Current network interface:${CE} $network_interface"
    echo -ne "${CYS}Enter new network interface name:${CE} "
    read new_network_interface
    if ifconfig "$new_network_interface" &>/dev/null; then
        echo "$new_network_interface" >> settings.conf
        network_interface="$new_network_interface"
        echo -e "${LGNS}Network interface changed to $network_interface.${CE}"
    else
        echo -e "${RS}Error: Network interface not found.${CE}"
    fi
}
function change_nick_name {
    echo -e "${YS}Current Nick Name:${CE} $nick_name"
    echo -ne "${CYS}Enter New Nick Name:${CE} "
    read new_nick_name
    echo "$new_nick_name" >> settings.conf
    nick_name="$new_nick_name"
    echo -e "${LGNS}Nick Name Changed To: $nick_name.${CE}"
}
function custom_install_git {
    echo -e "${YS}Paste Git Url:${CE}"
    read custom_git_url
    repo_name=$(basename "$custom_git_url" .git)
    git clone "$custom_git_url" "git/git-downloads/$repo_name"
    echo -e "${YS}Downloaded:${CE}"
    cd "git/git-downloads/$repo_name"
    ls
    echo -e "${YS}Run Command To Install [./install.sh] (If Needed):${CE}"
    read command_to_install
    $command_to_install
    echo -e "${YS}Done:${CE}"
}
##################################################################
############################  MAIN  ##############################
##################################################################
# Define main program loop
while true; do
    clear_screen
    display_menu
    read option
    case $option in
        1) display_ifconfig ;;
        2) htb_submenu;;
        3) git_installer_submenu;;
        00) settings_submenu;;
        0) exit ;;
        *) echo -e "${RS}Invalid option.${CE}" ;;
    esac
    echo -e "${CYS}Press Enter to continue.${CE}"
    read
done