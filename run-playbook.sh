#!/bin/bash

if [[ -z "$2" ]]; then
    echo "Usage: $0 <target> <playbook> <extra playbook arguments>"
    echo "<target> must be on of staging, lab, production and prod and <playbook> is a playbook without the .yml extension"
    exit 0;
fi

targets="staging lab production prod"
target=$1
playbook=$2

if [[ ! -e "./$playbook.yml" ]]; then
    echo "Playbook $playbook.yml does not exist" 
    exit 1;
fi

if [[ ! " $targets " =~ " $target " ]]; then
    echo "<target> must be on of staging, lab, prod or production"
    exit 1;
fi

if [[ "$target" == "production" ]]; then
    target="prod"
fi

vault_playbooks="graylog"
vault_arguments=""

if [[ " $playbook " =~ " $vault_playbooks " ]]; then
    vault_arguments="--vault-password-file .vault_password"
fi

# Shift so that $@ contains all remaining arguments
shift;
shift;

set -x
ansible-playbook $vault_arguments -i inventory.yml -l *_$target $playbook.yml $@
