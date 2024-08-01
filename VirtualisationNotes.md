# Notes for Virtualisation using KVM / QEMU / libvirt on Linux

- KVM is a Type 1 Hypervisor
    - Without an 'easy to use' interface
    - Provides acceleration through access to hardware virtualisation extensions

- QEMU is a Type 2 Hypervisor
    - When used with KVM it accelerates the performance of a QEMU guest and the combination (of KVM + QEMU) becomes a Type 1 Hypervisor

- libvirt
    - Toolkit to manage virtualisation platforms (like QEMU/KVM)

- End User Management tools
    - [Virtual Machine Manager](/virt-manager-notes.md) (Nice GUI App)
        - [`virt-manager`](https://virt-manager.org/) - GUI for managing Guest VMs
        - Create, edit, start and stop guest vms

    - [Cockpit/Web Console](/cockpit-notes.md)

    - [`virsh`](/virsh-cli-notes.md) CLI
    
    - oVirt/RHEV (Red Hat Enterprise Virtualisation)

### PreReqs : Does the CPU support Virtualisation?

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

NOTE : There is now [an ansible playbook](/hp-linux-servers/rhel-setup/rhel-setup-rdp.yml) to setup xrdp and firewall config
- `sudo firewall-cmd --zone=public --add-port=3389/tcp --permanent`

Reload to ensure changes are picked up
- `sudo firewall-cmd --reload`

## Networking

- Display
    - `ip addr`
- View Networking Scripts
    - `ls -la /etc/sysconfig/network-scripts`
- Can add multiple NIC's attached to different Networks