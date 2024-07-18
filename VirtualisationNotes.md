# Notes for Virtualisation using KVM / QEMU / libvirt on Linux

- KVM is a Type 1 Hypervisor
    - Without an 'easy to use' interface
    - Provides acceleration through access to hardware virtualisation extensions

- QEMU is a Type 2 Hypervisor
    - When used with KVM it accelerates the performance of a QEMU guest and the combination (of KVM + QEMU) becomes a Type 1 Hypervisor

- libvirt
    - Toolkit to manage virtualisation platforms (like QEMU/KVM)

- End User Management tools
    - Virtual Machine Manager (Nice GUI App)
        - [`virt-manager`](https://virt-manager.org/) - GUI for managing Guest VMs
        - Create, edit, start and stop guest vms

    - Cockpit/Web Console
    - `virsh` CLI
    - oVirt/RHEV (Red Hat Enterprise Virtualisation)

### Does the CPU support Virtualisation?

Are the KVM Modules loaded?
- `lsmod | grep kvm`

Does the Dev KVM Device exist?
- `ls -la /dev/kvm`

What 'Type' of CPU / Virtualisation?
- `lscpu | grep Virtualization`

How many CPU Cores?
- `egrep "vmx|svm" /proc/cpuinfo | wc -l`






# Optional

## Instal xrdp (Allows Remote Desktop Connection (RDP) from Windows)

- `sudo dnf -y install epel-release`
- `sudo dnf -y install xrdp`
- `sudo systemctl enable xrdp --now`
- `sudo systemctl status xrdp`

## Firewall

List the current firewall config
- `sudo firewall-cmd --list-all`

Enable port 3389 for RDP Connections and persist between reboots

NOTE : This is now done via [ansible](/hp-linux-servers/rhel-setup/rhel-setup-rdp.yml)
- `sudo firewall-cmd --zone=public --add-port=3389/tcp --permanent`

Reload to ensure changes are picked up
- `sudo firewall-cmd --reload`

## virt-manager (Graphical)

What is included in the 'Virtualization Client' Group? 
- `dnf groupinfo Virtualization\ Client`

** MANUAL CHANGES REQUIRED HERE **

After running the [rhel-setup-enable-virtualisation](/hp-linux-servers/rhel-setup/rhel-setup-enable-virtualisation.yml) playbook - you need to :

1. Edit the `/etc/libvirt/libvirtd.conf` file
1. Uncomment the line `unix_sock_group = "libvirt"` - This will allow us to add the <`user-name`> to the libvirt group (to allow that user access to the unix socket)
1. Uncomment the line `unix_sock_rw_perms = "0770"` - This will set the correct socket permissions
1. Add <`user-name`> to the `libvirt` group by running
    
    `usermod -a -G libvirt <user-name>`

1. Confirm Group Membership with - the user should now show in the libvirt group

    `groups <user-name>`

