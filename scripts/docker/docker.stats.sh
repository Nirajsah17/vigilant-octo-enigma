# #!/bin/bash

# function header(){
#   local header1="Container"
#   local header2="Images "
#   local header3="Network "
#   local header4="Volume "
#   printf "%-20s %-20s %-20s %-20s\n" "$header1" "$header2" "$header3" "$header4"
#   local container_length=$(docker ps -aq| wc -l)
#   local image_length=$(docker images -q| wc -l)
#   local network_length=$(docker network ls -q| wc -l)
#   local volume_length=$(docker volume ls -q| wc -l)
#   printf "%-200s %-20s %-20s %-20s\n" "$container_length" "$image_length" "$network_length" "$volume_length"

# }

# header "$@"

#!/bin/bash

function header(){
  local header1="Container"
  local header2="Images "
  local header3="Network "
  local header4="Volume "
  printf "%-20s %-20s %-20s %-20s\n" "$header1" "$header2" "$header3" "$header4"

  # Get the number of containers, images, networks, and volumes
  local container_length=$(docker ps -aq| wc -l)
  local image_length=$(docker images -q| wc -l)
  local network_length=$(docker network ls -q| wc -l)
  local volume_length=$(docker volume ls -q| wc -l)

  # Print the data
  printf "%-200s %-20s %-20s %-20s\n" "$container_length" "$image_length" "$network_length" "$volume_length"
}


function get_volume_usage(){
  local volumes=$(docker volume ls -q)
  for volume in $volumes; do
    volume_info=$(docker volume inspect -f '{{.Mountpoint}}, {{.Driver.DataSize / 1024 / 1024}}MB' "$volume")
    volume_info_array=($(echo "$volume_info" | jq -r 'split(", ")'))
    printf "%-20s %-20s\n" "${volume_info_array[0]}" "${volume_info_array[1]}"
  done
}

# Call the header function
header "$@"

# get_volume_usage "$@"