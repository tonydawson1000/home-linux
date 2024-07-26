# Virtual Machine Manager (`virt-manager`)

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/5.1%20Introduction%20to%20virt-manager.txt)

## Description
A graphical utility that we can use to manage guest virtual machines that run on QEMU/KVM hypervisors

Virtual Machine Manager runs in a user space and leverages `libvirt` to access the underlying hypervisor(s).  Because of this, `virt-manager` doesn't have to know how to ***"talk to"*** each particular hypervisor, it only has to communicate with `libvirt` via the `libvirtd` service on each host.

From the [Virtual Machine Manager website:](https://virt-manager.org/)

    "The `virt-manager` application is a desktop user interface for managing virtual machines through `libvirt`. It primarily targets KVM VMs, but also manages Xen and LXC (Linux Containers). It presents a summary view of running domains, their live performance, and resource utilization statistics. Wizards enable the creation of new domains, and configuration and adjustment of a domain’s resource allocation and virtual hardware. An embedded VNC and SPICE client viewer presents a full graphical console to the guest domain."

## Installation

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/5.2%20Installing%20and%20Configuring%20virt-manager%20on%20CentOS%208.txt)

Install `virt-manager` and associated packages

1. What is included in the `Virtualization Client` Group?
    - `dnf groupinfo Virtualization\ Client`

1. Install the `Virtualization Client` Group
    - Ansible [playbook](/hp-linux-servers/rhel-setup/rhel-setup-enable-virtualisation.yml)
    
    or
    - `sudo dnf -y group install --with-optional Virtualization\ Client`

## Configuration 

** `START` MANUAL CHANGES REQUIRED HERE - `START` **

1. Edit the `/etc/libvirt/libvirtd.conf` file

1. Uncomment the line `unix_sock_group = "libvirt"` - This will allow us to add the <`user-name`> to the libvirt group (to allow that user access to the unix socket)

1. Uncomment the line `unix_sock_rw_perms = "0770"` - This will set the correct socket permissions

1. Add <`user-name`> to the `libvirt` group by running
    
    `sudo usermod -a -G libvirt 'id -un'`

1. Add <`user-name`> to the `libvirtdbus` group by running

    `sudo usermod -a -G libvirtdbus 'id -un'`

1. Confirm Group Membership - the user should now show in the `libvirt` and `libvirtdbus` group

    `groups <user-name>`

** `END` MANUAL CHANGES REQUIRED HERE `END` **

## Validation

Validate the installation and KVM support

1. Ensure the `libvirtd` service is running (e.g. enabled and active)
    - `sudo systemctl status libvirtd`

1. Ensure the KVM Kernel Modules are loaded
    - `lsmod | grep -i kvm`

1. Ensure the `/dev/kvm` Device is available
    - `ls -al /dev/kvm`

1. Ensure (count) the CPUs that support Virtualisation
    - `egrep "svm|vmx" /proc/cpuinfo | wc -l`

1. Start the `Virtual Machine Manager` application from the GUI

## Create a new VM using Virtual Machine Manager (`virt-manager`)

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/5.3%20Creating%20a%20Virtual%20Machine%20Using%20virt-manager.txt)

1. Create New Virtual Machine (from downloaded .iso) / Setup new 'Pool' (Folder with .iso file in)

1. Set CPU and Memory

1. Create Storage

1. Set VM Name

1. Customise the following:
    - `Changes to IDE Disk 1 -> Set Advanced Options -> Disk bus to 'VirtIO'`
    - `Changes to NIC -> Set Device Model -> 'virtio'`
    - `Changes to Video QXL -> Set Model -> 'Virtio'`

## Manage a VM using Virtual Machine Manager (`virt-manager`)

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/5.4%20Managing%20a%20Virtual%20Machine%20Using%20virt-manager.txt)

1. Clone VM - from a 'shutdown' VM

1. Snapshot VM (Create New and Restore From)

1. Change VM Resources (RAM)

## Manage Virtual Networking using Virtual Machine Manager (`virt-manager`)

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/5.5%20Managing%20Networking%20Using%20virt-manager.txt)

1. Add a New Virtual Network Interface to a VM
    - VM has connection to the `default` (NAT) Network - allows access to the outside world
    - New NIC required to attach to the `internal` Network

    - List all NIC's
        - `ip addr`

    - View Network Config Files
        - `ls -la /etc/sysconfig/network-scripts/`
    
1. Create a New Virtual Network with `virt-manager`

1. Connect the VM to the new Virtual Network

## Manage Storage using Virtual Machine Manager (`virt-manager`)

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/5.6%20Managing%20Storage%20Using%20virt-manager.txt)

1. Add a Virtual Disk

    - Volumes and Volume Groups

        - List `Physical Volume(s)`
            - `sudo pvs`
        - List `Logical Volume(s)`
            - `sudo lvs`
        - List `Volume Groups(s)`
            - `sudo vgs`

    - Disks and Partitions

        - List `Virtual Disk Devices` and Partitions
            - `ls -la /dev/vd*`
        - List `Physical Disk Devices` and Partitions
            - `ls -la /dev/sd*`

    - Add New `Storage` Hardware (from Virtual Machine Manager GUI)
        - Set size (GBs)
        - Ensure `Bus type` is `VirtIO`

    - Ensure New Storage now shows from VM
        - List `Virtual Disk Devices` and Partitions
        - `ls -la /dev/vd*`

    - List `Partition Table` on Disk
        - `sudo fdisk -l /dev/<disk-device>`
        - e.g `sudo fdisk -l /dev/vdb`
        - NOTE : No `Partition Table` yet

    - Create a new `Physical Volume` on Disk
        - `sudo pvcreate /dev/<disk-device>`
        - e.g. `sudo pvcreate /dev/vdb`
        - NOTE : Can give the `pv` the entire space on the `disk`
    
    - Create a new `Volume Group` and add the new `pv` to it
        - `sudo vgcreate <volume-group-name> /dev/<disk-device>` 
        - e.g. `vgcreate web-vg /dev/vdb`

1. Configure the new Virtual Disk using LVM

    - Create a new `Logical Volume`, give it a size and add to the new `Volume Group`
        - `sudo lvcreate -L <size>G -n <logical-volume-name> <volume-group-name>`
        - e.g. `sudo lvcreate -L 4G -n web-content web-vg` 

    - Verify ...
        - Check
            - List `Physical Volume(s)`
                - `sudo pvs`
            - List `Logical Volume(s)`
                - `sudo lvs`
            - List `Volume Groups(s)`
                - `sudo vgs`

1. Format and Mount the new Logical Volume

    - Format the new `Logical Volume`
        - `sudo mkfs.xfs /dev/mapper/<logical-volume-name>`
        - e.g. `sudo mkfs.xfs /dev/mapper/web--vg-web--content`

    - Create a new `Mount Point` (Folder to Mount the new Logical Volume to)
        - `sudo mkdir <mount-point-name>`
        - e.g. `sudo mkdir /web`

    - Edit fstab and add a new entry for our mount point
        - `sudo vim /etc/fstab`

        - Copy the XFS line and duplicate - using the correct Volume and Mount Point
            - `/dev/mapper/<logical-volume-name>    /<mount-point-name> xfs defaults    0   0`
            - e.g. `/dev/mapper/web--vg-web--content    /web xfs defaults    0   0`
            - NOTE : Ensure file format / Tabs - Save and Quit

    - Mount
        - `sudo mount -a`

    - View Mount Point is Mounted correctly
        - `df -h`

1. Connect an ISO file to the Virtual Media Drive and Mount it

    - Browse to `.iso` file from `IDE CDROM 1` option in Virtual Machine Manager GUI -> Hardware

    - Ensure the Device exists
        - `ls -la /dev/sr0`
    
    - Ensure the `mnt` directory is empty
        - `ls -la /mnt`
    
    - Mount the Device
        - `sudo mount /dev/sr0 /mnt`
    
    - View the files
        - `ls -la /mnt`
    
    - View Disks
        - `df -h`
    
    - Unmount
        - `sudo umount /mnt`