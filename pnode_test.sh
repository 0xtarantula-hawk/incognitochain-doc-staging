#!/bin/bash

### Colors ##
ESC=$(printf '\033')
RESET="${ESC}[0m"
BLACK="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }
fn_bye() { exit 0; }
fn_fail() { echo "Wrong Option" exit 1; }


echo '
 ██╗███╗░░██╗░█████╗░░█████╗░░██████╗░███╗░░██╗██╗████████╗░█████╗░░░░░█████╗░██████╗░░██████╗░
 ██║████╗░██║██╔══██╗██╔══██╗██╔════╝░████╗░██║██║╚══██╔══╝██╔══██╗░░░██╔══██╗██╔══██╗██╔════╝░
 ██║██╔██╗██║██║░░╚═╝██║░░██║██║░░██╗░██╔██╗██║██║░░░██║░░░██║░░██║░░░██║░░██║██████╔╝██║░░██╗░
 ██║██║╚████║██║░░██╗██║░░██║██║░░╚██╗██║╚████║██║░░░██║░░░██║░░██║░░░██║░░██║██╔══██╗██║░░╚██╗
 ██║██║░╚███║╚█████╔╝╚█████╔╝╚██████╔╝██║░╚███║██║░░░██║░░░╚█████╔╝██╗╚█████╔╝██║░░██║╚██████╔╝
 ╚═╝╚═╝░░╚══╝░╚════╝░░╚════╝░░╚═════╝░╚═╝░░╚══╝╚═╝░░░╚═╝░░░░╚════╝░╚═╝░╚════╝░╚═╝░░╚═╝░╚═════╝░



               _   _           _        _____  _                             _   _
              | \ | |         | |      |  __ \(_)                           | | (_)
         _ __ |  \| | ___   __| | ___  | |  | |_  __ _  __ _ _ __   ___  ___| |_ _  ___
        |  _ \|     |/ _ \ / _  |/ _ \ | |  | | |/ _  |/ _  |  _ \ / _ \/ __| __| |/ __|
        | |_) | |\  | (_) | (_| |  __/ | |__| | | (_| | (_| | | | | (_) \__ \ |_| | (__
        |  __/|_| \_|\___/ \____|\___| |_____/|_|\__ _|\__, |_| |_|\___/|___/\__|_|\___|
        | |                                             __/ |
        |_|                                            |___/



Welcome to the pNode Diagnostic Script. This script will automagically download & install the following programs:

- Smartmontools - For testing SSD drives
- Memtester     - For testing RAM memory
- Htop          - Awesome overview tool
- Speedtest-cli - For checking internet speeds
'

sleep 5


echo $(magentaprint 'Updating apt')
sleep 3
apt update
sleep 1
echo $(magentaprint 'Installing Smartmontools, Memtester, Htop, Speedtest-cli')
sleep 3
apt install smartmontools memtester htop speedtest-cli
sleep 1
echo $(magentaprint 'Starting SSD test for issues')
sleep 3
smartctl -t long /dev/sda
sleep 1
echo $(magentaprint 'Test pNode RAM for issues')
sleep 3
memtester 2048 1 &>> /home/nuc/pnode_ramtest.txt
sleep 1
smartctl -a /dev/sda >> /home/nuc/pnode_disktest.txt
speedtest-cli
sleep 3