# home-linux
A bit of Ansible for some fun homelab automation!

## Prereqs
Before you can run Ansible against a 'host' ("Target Machine(s)") you must add your local ssh key to the 'host(s)' (so it knows who you are)

1. Optional - if you haven't already generated your local (Ansible Controller) SSH Key Pair...

    - `ssh-keygen`

1. Copy your (Ansible Controller) PUBLIC ssh key (the file (`ls ~/.ssh` one ending in `.pub`) to the remote Host(s) you want to Target with Ansible

    - `ssh-copy-id <name>@<host>`
    - e.g.
    - `ssh-copy-id tdawson@hpi516`
    - `ssh-copy-id tdawson@hpi732` 

NOTE : If the User is different (e.g `tonydawson` on one side and `tdawson` on the other) - you will need to set this explicitly in the [hosts](/hp-linux-servers/hosts.ini) file

```
[all:vars]
ansible_user=<name>
```

## Test Connection with Ansible Ping/Pong

With the remote public keys in place, try an Ansible Ping

- `ansible -i hosts.ini all -m ping`

You should get a 'Pong' in return...

## View Ansible Galaxy Roles and Collections

| Galaxy Role Name                                                                                                  | View Info Command                                         |
|---                                                                                                                |---                                                        |
| [`linux-system-roles.cockpit`](https://galaxy.ansible.com/ui/standalone/roles/linux-system-roles/cockpit/)        | `ansible-galaxy role info linux-system-roles.cockpit`     |
| [`linux-system-roles.rhc`](https://galaxy.ansible.com/ui/standalone/roles/linux-system-roles/cockpit/)            | `ansible-galaxy role info linux-system-roles.rhc`         |
| [`linux-system-roles.firewall`](https://galaxy.ansible.com/ui/standalone/roles/linux-system-roles/firewall/)      | `ansible-galaxy role info linux-system-roles.firewall`    |


## Install Ansible Galaxy Roles and Collections

- `ansible-galaxy install -r galaxy-requirements.yml`

## Ansible Playbooks

| Ansible Playbook Name                                                                                     | Description                               |
|---                                                                                                        |---                                        |
| [rhel-setup-enable-cockpit.yml](/hp-linux-servers/rhel-setup/rhel-setup-enable-cockpit.yml)               | Enable Cockpit (`http://<hostname>:9090`) |
| [rhel-setup-subscribe.yml](/hp-linux-servers/rhel-setup/rhel-setup-subscribe.yml)                         | Subscribe to Red Hat                      |
| [rhel-setup-update-packages.yml](/hp-linux-servers/rhel-setup/rhel-setup-update-packages.yml)             | Update ALL Packages                       |
| [rhel-setup-enable-epel.yml](/hp-linux-servers/rhel-setup/rhel-setup-enable-epel.yml)                     | Install and Enable EPEL Repo              |
| [rhel-setup-rdp.yml](/hp-linux-servers/rhel-setup/rhel-setup-rdp.yml)                                     | Install xrdp and allow Firewall           |
| [rhel-setup-enable-virtualisation.yml](/hp-linux-servers/rhel-setup/rhel-setup-enable-virtualisation.yml) | Install Virtualisation tools / GUI        |


## Run the Ansible Playbooks

| Playbook                          | Command                                                                                                                                                   |
|---                                |---                                                                                                                                                        |
| Enable Cockpit                    | `ansible-playbook rhel-setup/rhel-setup-enable-cockpit.yml -e "hostlist=all" --ask-become-pass`                                                           |
| Subscribe                         | `ansible-playbook rhel-setup/rhel-setup-subscribe.yml -e "hostlist=all orgid=<enter-org-id> activationkey=<enter-activation-key>" --ask-become-pass`      |
| Update ALL Packages               | `ansible-playbook rhel-setup/rhel-setup-update-packages.yml -e "hostlist=all" --ask-become-pass`                                                          |
| Install and Enable EPEL Repo      | `ansible-playbook rhel-setup/rhel-setup-enable-epel.yml -e "hostlist=all" --ask-become-pass`                                                              |
| Install xrdp and allow Firewall   | `ansible-playbook rhel-setup/rhel-setup-rdp.yml -e "hostlist=all" --ask-become-pass`                                                                      |
| Install Virtualisation tools / GUI| `ansible-playbook rhel-setup/rhel-setup-enable-virtualisation.yml -e "hostlist=all" --ask-become-pass`                                                    |


## Ansible AdHoc Commands

| Command                                                           | Description                                                                           |
|---                                                                |---                                                                                    |
| `ansible -i hosts.ini all -b -a "/sbin/shutdown -r now" -K`       | Reboot the hosts  ** WARNING ** - This command Reboots the Hosts!! ** WARNING **      |