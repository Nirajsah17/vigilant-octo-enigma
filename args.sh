#!/bin/bash

local _key
local _val
declare -A args
while [[ "$#" > "0" ]]; do
  case "$1" in 
    (*=*)
        _key="${1%%=*}" &&  _key="${_key/--/}" && _val="${1#*=}"
        args[${_key}]="${_val}"
        ;;
    (--*)
        _key="${1--%%*}" &&  _key="${_key/--/}" && _val=1
        args[${_key}]="${_val}"
        # (>&2 echo -e "key:val => ${_key}:${_val}")
        ;;
  esac
  shift
done