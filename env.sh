#!/bin/bash

function _env_setup_() {
  local LSCRIPTS=$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )
  source "${LSCRIPTS}/args.sh" $@
  source "${LSCRIPTS}/core.sh" $@
  source "${LSCRIPTS}/alias.sh" $@
}

_env_setup_ "$@"