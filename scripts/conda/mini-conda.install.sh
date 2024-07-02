#/bin/bash

# __author__ =  niraj kumar


function conda_install_main(){
  read -p "Are you sure you want to install mini conda ? (yes/no) [y/n/Y/N] " answer
  if [ -z "$answer" ]; then
    answer="y"
  fi
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "Installing mini conda..."
    conda_install "$@"
    conda_help "$@"
  elif [ "$answer" = "n" ] || [ "$answer" = "N" ]; then
    echo "Installation cancelled."
  else
    echo "Please enter 'y' for yes or 'n' for no."
  fi
}


function conda_install() {
  echo "Downloading mini conda scripts..."
  local anaconda_installer=$(wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh)
  echo "verifying intergrity of conda installer"
  sha256sum Miniconda3-latest-Linux-x86_64.sh
  bash Miniconda3-latest-Linux-x86_64.sh
  rm Miniconda3-latest-Linux-x86_64.sh
  # Initialize Miniconda
  source ~/miniconda3/bin/activate
  conda init
  # Verify the installation
  local cond_version=$(conda --version)
  echo "conda version: $cond_version"
  echo "conda installed sucessfully"
}

function conda_help(){
  echo "Usage: conda_install_main [options]"
  echo "Options:"
  echo "  -h, --help"
  echo "  -v, --version"
  echo "  -d, --debug"
  echo "  -c, --clean"
  echo "create a new virtual environment"
  echo "conda env create -n [env_name]"
  echo "conda list environment"
  echo "conda env list"
  echo "conda activate [env_name]"
}

conda_install_main "$@"