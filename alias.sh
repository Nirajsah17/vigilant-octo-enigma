#!/bin/bash

# __author__ =  niraj kumar

# Define all alias functions
function alias_kill_gnome() {
  alias kill-gnome='killall -HUP gnome-shell'
  alias kill-show='echo "killall -HUP gnome-shell"'
}

function alias_practice() {
  alias practice='cd ${__CODEHUB_ROOT__}/aihub/practice/niraj/'
}

function alias_build_vyzor() {
  alias build.vyzor="bash ${LSCRIPTS}/scripts/vyzor.build.sh"
}

function alias_docker_commands() {
  alias docker-image.list="docker images"
  alias docker-container.list="docker ps -a"
  alias docker-volume-list="docker volume list"
  alias docker-network-list="docker network list"
  alias docker-volume.dangling="docker volume prune -f"
  alias docker-network.dangling="docker network prune -f"
  alias docker-container.remove="docker rm \$1"
  alias docker-container.remove.f="docker rm \$1 -f"
  alias docker-image.remove="docker rmi \$1"
  alias docker-image.remove.f="docker rmi \$1 -f"
  alias docker-container.hostname="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \$1"
  alias docker-container.bash="docker exec -it \$1 bash"
  alias docker-container.sh="docker exec -it \$1 sh"
  alias docker-containers.remove.all="docker rm $(docker ps -aq)"
  alias docker-containers.remove.all.f="docker rm $(docker ps -aq) -f"
  alias docker-images.remove.all"=docker rm $(docker images -q)"
  alias docker-images.remove.all.f="docker rmi $(docker images -q) -f"
  alias docker-volumes.remove.all="docker volume rm $(docker volume list -q)"
  alias docker-volumes.remove.all.f="docker volume rm $(docker volume list -q) -f"
  alias docker-stats="bash ${LSCRIPTS}/scripts/docker/docker.stats.sh"
  
}

function alias_ssh_commands() {
  alias ssh-pallawi="ssh ce00132421@10.10.21.207"
  alias ssh-kaushal="ssh cn003445@10.10.21.126"
  alias ssh-susheel="ssh ce00142422@10.10.22.12"
}

function alias_search_cmds() {
  alias search-cmds="alias | grep \$1"
}

function alias_conda_commands() {
  alias conda-list="conda env list"
  alias conda-create="conda env create -n \$1"
  alias conda-create.python="bash ${LSCRIPTS}/scripts/conda/mini-conda.create-env.sh"
  alias conda-remove="conda env remove --name \$1"
  alias conda-activate="conda activate \$1"
  alias conda-deactivate="conda deactivate"
}

# Main function to call all alias functions
function __alias.main__() {
  local LSCRIPTS=$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )
  alias_kill_gnome
  alias_practice
  alias_build_vyzor
  alias_docker_commands
  alias_ssh_commands
  alias_search_cmds
  alias_conda_commands
}

# Call the main function to set up aliases
__alias.main__
