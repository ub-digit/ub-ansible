# ub-ansible
Playbooks can be run directly using ansible-playbook (to dry-run add the -C or --check option):
`ansible-playbook -i inventory.yml apache-certs.yml`

or through the wrapper script ./run-playbook.sh as:

`./run-playbook <target> <playbook> <extra playbook arguments>`

Extra ansible-playbook arguments can be provided after the playbook name,
for example:

`./run-playbook staging ezproxy-certs -C`

to dry-run the ezproxy-cert playbook on staging.
