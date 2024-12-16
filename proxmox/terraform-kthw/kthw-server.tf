resource "proxmox_vm_qemu" "kthw_server" {
  vmid        = var.kthw_server_vm_id
  name        = var.kthw_server_vm_name
  target_node = var.kthw_server_vm_target_node

  clone = var.kthw_vm_template

  bios   = "seabios"
  agent  = 1
  scsihw = "virtio-scsi-pci"

  os_type  = "cloud-init"
  cpu_type = "host"
  sockets  = 1
  cores    = var.kthw_server_vm_cpu_cores
  memory   = var.kthw_server_vm_ram

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size      = 64
          cache     = "writeback"
          storage   = "local-lvm"
          replicate = true
        }
      }
    }
  }

  network {
    id        = 0
    bridge    = "vmbr0"
    firewall  = true
    link_down = false
    model     = "virtio"
  }

  # Setup the ip address using cloud-init.
  boot = "order=scsi0"
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0 = "ip=10.25.20.21/24,gw=10.25.20.1"
}