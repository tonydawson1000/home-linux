# `virsh` CLI - For Storage

[link](https://raw.githubusercontent.com/ACloudGuru-Resources/KVM-Virtualization-on-Linux/master/7.6%20Managing%20Virtual%20Storage%20Using%20virsh.txt)

The `virsh` command enables us to manipulate storage pools, volumes, and snapshots

[libvirt: Storage Management](https://libvirt.org/storage.html)

[libvirt: virsh](https://libvirt.org/manpages/virsh.html#synopsis)

## Storage Pools
- List all Storage Pools
    - `sudo virsh pool-list --all`

- View Info for a specific Storage Pool
    - `sudo virsh pool-info <pool-name>`

- Create a New Virtual Storage Pool
    - `sudo virsh pool-define-as DBA_Team dir - - - - "/home/DB_Virtual_Machines"`

- Build the Pool
    - `sudo virsh pool-build DBA_Team`

- View the Dir
    - `ls -la /home/`

- Set the Pool to Auto Start
    - `sudo virsh pool-autostart DBA_Team`

- Start the Pool
    - `sudo virsh pool-start DBA_Team`

- List all Storage Pools
    - `sudo virsh pool-list --all`

- View Pool Details
    - `sudo virsh pool-info DBA_Team`

## Volumes (Disks)

- Create a New Volume in a Pool
    - `sudo virsh vol-create-as <pool-name> <name.qcow2> <size-G> --format qcow2`
        - e.g. 
            
            `sudo virsh vol-create-as DBA_Team vmrhel9hpi732-db1.qcow2 10G --format qcow2`

            `sudo virsh vol-create-as Base_Virtual_Machines vmdeb12-base-data.qcow2 10G --format qcow2`

- Delete an existing Volume
    - `sudo virsh vol-delete <vol-name> --pool <pool-name>`

- View the Volume(s) (.qcow2 Files) on the File System 
    - `sudo ls -la /home/<pool-name>`
    - e.g.

        `sudo ls -la /home/DB_Virtual_Machines/`

        `sudo ls -la /home/Base_Virtual_Machines/`

- View the Volume(s) (.qcow2 Files) in the `Storage Pool`
    - `sudo virsh vol-list <storage-pool-name>`
    - e.g.

        `sudo virsh vol-list DBA_Team`

        `sudo virsh vol-list Base_Virtual_Machines`

## Attach the Volume(s) / Disks to a VM (Domain)

NOTE : Shutting the VM down is required before adding/removing Virtual Devices

- View the current Block Info for the VM
    - `sudo virsh domblkinfo <vm-name>> --all`
    - e.g.

        `sudo virsh domblkinfo vmrhel9hpi732-cockpit --all`

        `sudo virsh domblkinfo vmdeb12-base --all`

- Power off the VM (Domain)
    - `sudo virsh shutdown <vm-name>`
    - e.g. 

        `sudo virsh shutdown vmrhel9hpi732-virt`

        `sudo virsh shutdown vmdeb12-base`

- Ensure the VM is powered off
    - `sudo virsh list --all`

- Attach the Volume(s) / Disk(s)

    ---
    NOTE : Dont forget to specify the 'non-default' values for `driver` and `subdriver` (the default format is RAW)
    ---

    ```
    sudo virsh attach-disk \
    <vm-name> \
    --source <qcow-file-location> \
    --target vdb \
    --cache none \
    --driver qemu \
    --subdriver qcow2 \
    --config 
    ```

    e.g. (`vmrhel9hpi516-virt`)

    ```
    sudo virsh attach-disk \
    vmrhel9hpi516-virt \
    --source /home/DB_Virtual_Machines/vmrhel9hpi516-virt-db1.qcow \
    --target vdb \
    --cache none \
    --driver qemu \
    --subdriver qcow2 \
    --config
    ```

    or (`vmdeb12-base`)

    ```
    sudo virsh attach-disk \
    vmdeb12-base \
    --source /home/Base_Virtual_Machine/vmdeb12-base-data.qcow2 \
    --target vdb \
    --cache none \
    --driver qemu \
    --subdriver qcow2 \
    --config
    ```

- Validate the Volume(s) (.qcow2 Files) exist in the `Storage Pool`
    - `sudo virsh vol-list <storage-pool-name>`
    - e.g.

        `sudo virsh vol-list DBA_Team`

        `sudo virsh vol-list Base_Virtual_Machines`

- Validate the Block Devices attached to the VM
    - `sudo virsh domblkinfo <vm-name>> --all`
    - e.g.

        `sudo virsh domblkinfo vmrhel9hpi732-cockpit --all`

        `sudo virsh domblkinfo vmdeb12-base --all`


- Start the VM (Domain)
    - `sudo virsh start <vm-name>`

- Connect to the console
    - `sudo virsh console <vm-name>`

- List the Devices
    - `ls -la /dev/vd*`

- List the Disks
    - `sudo fdisk -l | grep vd`

---

# Snapshots

- List snapshots for a VM (Domain)
    - `sudo virsh snapshot-list <vm-name>`
    - e.g. 

        `sudo virsh snapshot-list vmrhel9hpi732-virt`

        `sudo virsh snapshot-list vmdeb12-base`

- Create a new snapshot
    - `sudo virsh snapshot-create-as <vm-name> <snapshot-description>`
    - e.g. 

        `sudo virsh snapshot-create-as vmrhel9hpi732-virt initial-snapshot`

        `sudo virsh snapshot-create-as vmdeb12-base initial-snapshot`

- View existing snapshots for VM
    - `sudo virsh snapshot-list <vm-name>`
    - e.g.
        
        `sudo virsh snapshot-list vmrhel9hpi732-virt`

        `sudo virsh snapshot-list vmdeb12-base`

- View details on snapshot
    - `sudo virsh snapshot-info <vm-name> --current`
    - e.g.

        `sudo virsh snapshot-info vmrhel9hpi732-virt --current`

        `sudo virsh snapshot-info vmdeb12-base --current`

- Rollback to snapshot
    - `sudo virsh snapshot-revert <vm-name> --current`
    - e.g.

        `sudo virsh snapshot-revert vmrhel9hpi732-virt --current`

        `sudo virsh snapshot-revert vmdeb12-base --current`