#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: $0 PLAYBOOK [TARGET] [EXTRA_ARGUMENTS]"
    echo "TARGET if provided must be on of staging, lab, production and prod, and PLAYBOOK is a playbook without the .yml extension"
    exit 0;
fi

targets="staging lab dev production prod"
playbook=$1

if [[ ! -e "./$playbook.yml" ]]; then
    echo "Playbook $playbook.yml does not exist" 
    exit 1;
fi

# Find out if target or extra arguments
if [[ -n $2 && $2 != -* ]]; then
    target=$2

    if [[ ! " $targets " =~ " $target " ]]; then
        echo "<target> must be on of staging, lab, dev, prod or production"
        exit 1;
    fi

    if [[ "$target" == "production" ]]; then
        target="prod"
    fi

    host_filter="-l *_$target"
    # Since target was provided we need to shift off an extra argument
    shift;
fi

vault_playbooks="graylog"
vault_arguments=""

if [[ " $playbook " =~ " $vault_playbooks " ]]; then
    vault_arguments="--vault-password-file .vault_password"
fi

# Shift so that $@ contains all remaining arguments
shift;

set -x
ansible-playbook $vault_arguments -i inventory.yml $host_filter $playbook.yml $@
