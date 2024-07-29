# `virsh` CLI

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/7.1%20Introduction%20to%20Linux%20CLI%20Utilities.txt)

The main interface for managing virsh guest domains

`libvirt` has a set of command-line tools

`virsh` is installed with the `libvirt` package 

## Description

From the ['libvirt'](https://libvirt.org/manpages/virsh.html#synopsis) website:

    “The virsh program is the main interface for managing virsh guest domains.”

Additional CLI Tools include:
- `virt-install` - Utility to Create VM's and Install OS's
- `virt-sysprep` - Utility to Create 'templates' from existing Guest VMs
- `virt-clone` - Utiltiy to Clone an existing VM
- `virt-v2v` - Utility to import VMs from a variety of different sources

## Basic `virsh` Usage / Commands

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/7.3%20Introduction%20to%20the%20virsh%20Shell.txt)

| Command                                       | Description                                                   |
|---                                            |---                                                            |
| Virsh Shell                                   |                                                               |
| `sudo virsh`                                  | Enter the virsh shell to execute commands directly            |
| Virtual Machines                              |                                                               |
| `list --all`                                  | List all VM's (in 'all' states inc powered off)               |
| `start <vm-name>`                             | Start a VM                                                    |
| `shutdown <vm-name>`                          | Shutdown a VM                                                 |
| `domid <vn-name>`                             | Get the ID of a Running VM / Domain                           |
| `domname <vm-id>`                             | Get the Name of a Running VM / Domain                         |
| `dumpxml <vm-name> OR <vm-id>`                | View the FULL XML config for a VM / Domain                    |
| Storage (Pools/Volumes)                       |                                                               |
| `pool-list --all`                             | List all the Storage Pools                                    |
| `vol-list <storage-pool-name>`                | List all the Volumes in a Storage Pool                        |
| - e.g. `vol-list Virtual_Machines`            |                                                               |
| CPU                                           |                                                               |
| `vcpuinfo <vm-name>`                          | View CPU Info for a VM / Domain                               |
| `vcpucount <vm-name>`                         | View CPU Count for a VM / Domain                              |
| Memory                                        |                                                               |
| `dommemstat <vm-name>`                        | View Memory Info for a VM / Domain                            |
| State                                         |                                                               |
| `dominfo <vm-name>`                           | View Basic Info for a VM / Domain                             |
| `domstate <vm-name>`                          | View the current 'State' of a VM / Domain                     |
| Storage                                       |                                                               |
| `domblkinfo <vm-name> --all`                  | View the Block Device(s) associated with a VM / Domain        |
| `domblkstat <vm-name>`                        | View Block Device Stats on a running VM / Domain              |
| Network                                       |                                                               |
| `domiflist <vm-name>`                         | View Network Interface list for VM / Domain                   |
| `domifstat --domain <vm-name> <if-name>`      | View Network Interface Stats on a running VM / Domain         |
| - e.g. `domifstat --domain vmrhel9hpi732-cockpit vnet0`   |                                                   |
| Hypervisor Capabilities                       |                                                               |
| `capabilities`                                | What the Hypervisor is capable of / configuration             |
| `hostname`                                    | Name of the virsh host                                        |
| `nodeinfo`                                    | Info for the Hypervisor Node (CPU's Memory)                   |
| `uri`                                         | Details for the connection                                    |

## Installation

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/7.2%20Installing%20the%20CLI%20Utilities%20on%20CentOS%208.txt)

Install `libvirt` and `virt-install` and associated packages

1.  Install Packages
    - `sudo dnf -y install qemu-kvm libvirt libguestfs-tools virt-install virt-v2v`

Validate the installation

1. Check the status of `libvird` to ensure its enabled and running
    - `sudo systemctl status libvirtd`

        To Enable and Start 
            
        - `sudo systemctl enable libvirtd`
        - `sudo systemctl start libvirtd`

1. Check the version of `virsh` we have running
    - `virsh version`

1. Check the 'host' passes the 'validation' required by `virsh`
    - `virt-host-validate`

1. Ensure we have a 'bridge' network that our VMs can connect to
    - `sudo virsh net-list`

1. View the full XML config for an item or device (e.g. the 'default' network config)
    - `sudo virsh net-dumpxml default`

        Get the mac address
        
        - `sudo virsh net-dumpxml default | grep mac`

## Create a Virtual Machine with `virsh`

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/7.4%20Using%20virt-install%20to%20Create%20a%20Virtual%20Machine.txt)

### virt-install

CLI Utility to install VM's

Docs - [Creating virtual machines by using the command-line interface](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html-single/configuring_and_managing_virtualization/index#creating-virtual-machines-using-the-command-line-interface_assembly_creating-virtual-machines)

List of available OS Variants (to supply in the `--os-variant` variable)
- `virt-install --osinfo list`

List details of available OS
- `osinfo-query os`

### Create VM (Template Command)
---

```
sudo virt-install \
 --name=<vm-name>> \
 --vcpus=2 \
 --memory=2048 \
 --disk pool=<storage-pool-name>,size=10,bus=virtio \
 --location <file-location-for-iso> \
 --os-variant=<os-variant-name> \
 --network network='default',model=virtio \
 --extra-args='console=ttyS0,115200n8 serial' \
 --nographics
```

---
### `virt-install` RHEL 9 example
```
sudo virt-install \
 --name=vmrhel9hpi732-virt \
 --vcpus=2 \
 --memory=2048 \
 --disk pool=Virtual_Machines,size=10,bus=virtio \
 --location /tmp/rhel-9.4-x86_64-dvd.iso \
 --os-variant=rhel9.4 \
 --network network='default',model=virtio \
 --extra-args='console=ttyS0,115200n8 serial' \
 --nographics
```
---
### `virt-install` Ubuntu 24.04 example
```
sudo virt-install \
 --name=vmubuntu24-04-base \
 --vcpus=2 \
 --memory=4096 \
 --disk pool=Virtual_Machines,size=10,bus=virtio \
 --location /tmp/ubuntu-24.04-desktop-amd64.iso \
 --os-variant=ubuntu24.04 \
 --network network='default',model=virtio \
 --extra-args='console=ttyS0,115200n8 serial' \
 --nographics
```
---
### `virt-install` Debian 12 example
```
sudo virt-install \
 --name=vmdeb12-base \
 --vcpus=2 \
 --memory=4096 \
 --disk pool=Virtual_Machines,size=10,bus=virtio \
 --location /tmp/debian-12.6.0-amd64-DVD-1.iso \
 --os-variant=debian12 \
 --network network='default',model=virtio \
 --extra-args='console=ttyS0,115200n8 serial' \
 --nographics
```
---

## Manage a Virtual Machine with `virsh`

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/7.5%20Using%20virsh%20to%20Manage%20Virtual%20Devices.txt)

Connect to VM Console
- `sudo virsh console <vm-name>`