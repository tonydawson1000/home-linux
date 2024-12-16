variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token" {
  type = string
}

variable "kthw_vm_template" {
  type    = string
  default = "debian-12-8-base"
}

///////////////////

variable "kthw_jumpbox_vm_id" {
  type    = number
  default = 2000
}
variable "kthw_jumpbox_vm_name" {
  type    = string
  default = "jumpbox"
}
variable "kthw_jumpbox_vm_cpu_cores" {
  type    = number
  default = 1
}
variable "kthw_jumpbox_vm_ram" {
  type    = number
  default = 1024
}
variable "kthw_jumpbox_vm_target_node" {
  type        = string
  description = "Node to create the VM on"
  default     = "pve1-i7-64"
}

///////////////////

variable "kthw_server_vm_id" {
  type    = number
  default = 2001
}
variable "kthw_server_vm_name" {
  type    = string
  default = "server"
}
variable "kthw_server_vm_cpu_cores" {
  type    = number
  default = 1
}
variable "kthw_server_vm_ram" {
  type    = number
  default = 2048
}
variable "kthw_server_vm_target_node" {
  type        = string
  description = "Node to create the VM on"
  default     = "pve1-i7-64"
}

///////////////////

variable "kthw_node0_vm_id" {
  type    = number
  default = 2002
}
variable "kthw_node0_vm_name" {
  type    = string
  default = "node-0"
}
variable "kthw_node0_vm_cpu_cores" {
  type    = number
  default = 1
}
variable "kthw_node0_vm_ram" {
  type    = number
  default = 2048
}
variable "kthw_node0_vm_target_node" {
  type        = string
  description = "Node to create the VM on"
  default     = "pve1-i7-64"
}

///////////////////

variable "kthw_node1_vm_id" {
  type    = number
  default = 2003
}
variable "kthw_node1_vm_name" {
  type    = string
  default = "node-1"
}
variable "kthw_node1_vm_cpu_cores" {
  type    = number
  default = 1
}
variable "kthw_node1_vm_ram" {
  type    = number
  default = 2048
}
variable "kthw_node1_vm_target_node" {
  type        = string
  description = "Node to create the VM on"
  default     = "pve1-i7-64"
}