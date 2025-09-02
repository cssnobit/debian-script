#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;3
3m'
NC='\033[0m'

if [ -z "$1" ]; then
	echo -e "${REDIt was not possible run the script! You must provide your user from computer like this: ./debian-initialize.sh your-user${NC}"
	exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
	echo -e "${RED}Please, don't run this script as root user!${NC}"
	exit 1
else
	echo -e "${YELLOW}Initialize script is running!${NC}"
	echo -e "${YELLOW}Becoming root user...${NC}"
	su -
	echo -e "${GREEN}Root with success${NC}"
	sleep 5s

	# Updating the system
	clear
	echo -e "${YELLOW}Updating and upgrading the system${NC}"
	apt update -y && apt upgrade -y
	echo -e "${GREEN}Done!${NC}"
	sleep 5s

	# Installing sudo
	clear
	echo -e "${YELLOW}Installing sudo${NC}"
	apt install sudo -y
	echo -e "${GREEN}Done!${NC}"
	sleep 5s

	# Adding user's machine as sudo
	clear
	echo -e "${YELLOW}Setting up sudo to user${NC}"
	usermod -aG sudo $1
	echo -e "${GREEN}Done!${NC}"
	sleep 5s

	# Restarting the machine
	clear
	echo -e "${YELLOW}Restarting your computer to apply changes...${NC}"
	sleep 3s
	systemctl reboot
fi
