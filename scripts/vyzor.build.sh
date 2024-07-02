#!/bin/bash

# __author__ =  niraj kumar

function __build.vyzor__(){
  local vyzor=${__CODEHUB_ROOT__}/aihub/apps/helix-vyzor/
  cd $vyzor
  bash build.sh :dev
}

__build.vyzor__ $@