#!/bin/sh
set -e

if [ -n "$1" ]; then
  case "$1" in
    -*|*.yml|*.yaml)
      exec ansible-playbook -i inventory.yml "$@"
      ;;
  esac
fi

exec "$@"
