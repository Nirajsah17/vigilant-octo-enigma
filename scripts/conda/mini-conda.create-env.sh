#/bin/bash

# __author__ =  niraj kumar

function __create.virtual.env.with_pythons__() {
  local name="$1"
  local python_version="$2"
  echo "Checking conda availability ..."
  local conda=$(conda --version)
  echo 
  if [ -z "$conda" ]; then
   echo "conda not available"
   return 1
  fi
  echo "conda available"
  # conda env create --name $1 python=$2
  conda create --name $1 python=$2

}

__create.virtual.env.with_pythons__ $@