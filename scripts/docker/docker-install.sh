#!/bin/bash

# __author__ =  niraj kumar

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function is_docker_exist() {
  local docker_version=$(docker --version 2>&1)
  echo -e "${GREEN}docker version ===========>>>> $docker_version${NC}"
  if [ "$docker_version" ]; then
    echo -e "${YELLOW}You already have Docker installed on your system. Do you want to uninstall the existing Docker and then proceed with the installation?${NC}"
    read -p "Are you sure you want to install Docker? (yes/no) [y/n/Y/N] " answer
    if [[ "$answer" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
      uninstall_docker
      install_docker
    elif [[ "$answer" =~ ^[Nn][Oo]?$ ]]; then
      echo -e "${RED}Exiting without installing Docker.${NC}"
      exit 0
    else
      echo -e "${RED}Invalid response. Exiting without installing Docker.${NC}"
      exit 1
    fi
  else
    install_docker
  fi
}

function uninstall_docker() {
  echo -e "${YELLOW}Uninstalling Docker...${NC}"
  sudo apt-get remove -y docker docker-engine docker.io containerd runc
}

function install_docker() {
  echo -e "${GREEN}Installing Docker...${NC}"
  sudo apt-get update
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  sudo systemctl start docker
  sudo systemctl enable docker
}

is_docker_exist "$@"
