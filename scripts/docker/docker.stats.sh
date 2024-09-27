# #!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


function header() {
  local container_length=$(docker ps -aq | wc -l)
  local image_length=$(docker images -q | wc -l)
  local network_length=$(docker network ls -q | wc -l)
  local volume_length=$(docker volume ls -q | wc -l)
  local process_count=$(count_container_processes)
  local space_usage=$(get_total_space_usage)

  echo -e "${YELLOW} Container ${NC}:" "$container_length"
  echo -e "${YELLOW} Images ${NC}:" "$image_length "
  echo -e "${YELLOW} Networks ${NC}:" "$network_length"
  echo -e "${YELLOW} Volumes ${NC}:" "$volume_length"
  echo -e "${YELLOW} processes ${NC}: $process_count"
  echo -e "${YELLOW} Space ${NC}: $space_usage"
}

count_container_processes() {
    local total_processes=0

    for container in $(docker ps -q || true); do
        # Get the number of processes in the container, handling errors gracefully
        container_processes=$(docker top $container -eo pid 2>/dev/null | wc -l || echo 1)
        # Subtracting 1 for header row, but ensuring it doesn't go below 0
        total_processes=$((total_processes + container_processes - 1))
    done

    # If total_processes is negative, set it to 0 (in case all wc -l return only headers)
    if [ $total_processes -lt 0 ]; then
        total_processes=0
    fi

    echo $total_processes
}

get_total_space_usage() {
    local total_space_usage=0
    local container_count=0

    # Iterate over each running container
    for container in $(docker ps -q || true); do
        # Get the disk usage for each container, if the command fails, continue to the next container
        container_size=$(docker inspect --format='{{.SizeRw}}' $container 2>/dev/null || echo 0)
        total_space_usage=$((total_space_usage + container_size))
        container_count=$((container_count + 1))
    done

    # If no containers are found, return 0
    if [ $container_count -eq 0 ]; then
        echo 0
    else
        echo $total_space_usage
    fi
}



# Call the header function
header "$@"

# get_volume_usage "$@"
