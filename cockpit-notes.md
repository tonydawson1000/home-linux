# Cockpit (Web Console)

[Red Hat Link](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html-single/configuring_and_managing_virtualization/index#creating-vms-using-the-rhel-web-console_creating-vms-and-installing-an-os-using-the-rhel-web-console)

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/6.1%20Introduction%20to%20Cockpit-Web%20Console.txt)

## Description
Cockpit/Web Console is a web application that we can use to manage not only the host but the guest virtual machines that run on QEMU/KVM hypervisors

Cockpit runs in the user space and leverages a plugin to use `libvirt` to access the underlying hypervisor.  Because of this, Cockpit doesn't have to know how to "talk to" the hypervisor, it only has to communicate with `libvirt` via the `libvirtd` service

From the [Cockpit Project website:](https://cockpit-project.org/)

    "The easy-to-use, integrated, glanceable, and open web-based interface for your servers."

## Installation

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/6.2%20Installing%20and%20Configuring%20Cockpit%20on%20CentOS%208.txt)

Install `cockpit` and the `cockpit-machines` plugin

1. Check to see if `Cockpit` or `virt` are already installed
    - `sudo dnf list installed | egrep -i "cockpit|virt"`

1. Install required packages
    - `sudo dnf -y install libvirt cockpit cockpit-machines`

1. Check for any updates
    - `sudo dnf -y update`

1. List the current firewall config - ensure `cockpit` service is allowed (http/9090) - see link to setup
    - `sudo firewall-cmd --list-all`

## Configuration 

1. Add a `<user>` to the libvirt group - this allows non-root users to administer Virtual Environment
    - `sudo usermod -a -G libvirt 'id -un'`
    - `sudo usermod -a -G libvirtdbus 'id -un'`
    - `sudo usermod -a -G libvirt libvirtdbus`
    - `sudo usermod -a -G libvirt qemu`

1. Change the Default Location for Virtual Disk File Location
    
    - Default location is `/var/lib/libvirt/images`

1. Create a new `location` for the Virtual Hard Disk(s)
    - `sudo mkdir /home/Virtual_Machines`

1. Set the `Ownership` (qemu) and `Group Ownership` (libvirt) on the folder
    - `sudo chown -R qemu:libvirt /home/Virtual_Machines`

1. Set the Permissions on the folder
    - `sudo chmod 0770 /home/Virtual_Machines`

1. Check changes
    - `sudo ls -la /home`

## Validation

1. Ensure the `cockpit` service is running (e.g. enabled and active)
    - `sudo systemctl status cockpit`
        
        To Enable
        - `sudo systemctl enable cockpit.socket --now`

1. Ensure the `libvirtd` service is running (e.g. enabled and active)
    - `sudo systemctl status libvirtd`

        To Enable
        - `sudo systemctl enable libvirtd --now`

## Connect to the `Cockpit` Web Console

1. Point a browser at `http://<hostname> or <ip-address>:9090`

1. Login with the `<user>` setup above (that has permissions to manage the virtual environment)

## Take a Tour of `Cockpit` - Virtual Machines

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/6.3%20Creating%20a%20Virtual%20Machine%20Using%20Cockpit.txt)

1. Note the `Storage Pools` and `Networks` 

## Create a new Virtual Machine

1. Download an ISO
    - Browse or `curl`
    - Place .iso file in /tmp

1. Ensure the .iso file exists
    - `ls -la /tmp`

1. Login to `Cockpit`
    - `http://<hostname> or <ip-address>:9090`

1. Setup a `Storage Pool` for the `/home/Virtual_Machines` folder created earlier (to store the Virtual Disk File Location)
    - Connection = `QEMU/KVM`
    - Name = `Virtual_Machines`
    - Type = `Filesystem Directory`
    - Target Path = `/home/Virtual_Machines`
    - Startup on boot = `true`

1. Create New Virtual Machine
    - Connection = `QEMU/KVM`
    - Name = `my-new-vm`
    - Installation Source Type = `Local Install Media`
    - Installation Source = `path-to-iso-file` (e.g. `/tmp/myiso.iso`)
    - Storage = `NO STORAGE` - we want to setup Storage in a non-default location (`/home/Virtual_Machines`)
    - Memory = 2GB
    - OS Vender = `choose from list`
    - Operating System = `choose from list`
    - Immediately Start VM = NO / FALSE - No Storage yet so wont boot!
    - Create

1. Add a new Virtual Disk and attach it to the VM
    - From the Cockpit Web
    - Locate the Virtual Machine
    - Locate Disk
    - Click Add Disk
    - Choose `Pool` (e.g. `Virtual_Machines`)
    - Name the `Volume`
    - Enter size
    - Format = `qcow2`
    - Persistence = `Always attach` = TRUE

1. Install the OS
    - From the console - Click `install`
    - Follow standard OS Installation

1. Start the VM
    - Following OS Installation, click `Start`

1. Patch
    - `sudo dnf -y update`

1. Shutdown / Power Off
    - `sudo systemctl poweroff`

## Manage Virtual Machine

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/6.4%20Managing%20Virtual%20Machines%20Using%20Cockpit.txt)

1. Add CPU Cores / Memory
    - Locate the VM in Cockpit
    - Ensure the VM is Powered Off
    - Click Edit next to CPU / Memory
    - Change value as desired
    - Start VM
    - Validate Memory change 
        - `grep MemTotal /proc/meminfo`
    - Validate the CPU change
        - `grep -i processor /proc/cpuinfo`

1. Add Disk
    - Review our current Disk setup
        - `sudo fdisk -l`
    - Review our current Virtual Devices
        - `ls -la /dev/vd*`
    - Locate the VM and Click `Add disk`
        - Choose `Pool` (e.g. `Virtual_Machines`)
        - Name the Volume
        - Enter size
        - Format = `qcow2`
        - Persistence = `Always attach` = TRUE
    - Validate the New Volume
        - `ls -la /dev/vd*`
    - Validate the New Disk
        - `sudo fdisk -l`