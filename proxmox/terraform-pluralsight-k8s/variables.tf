variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token" {
  type = string
}

variable "pluralsight_vm_template" {
  type    = string
  default = "debian-12-8-base"
}

///////////////////

variable "c1_cp1_vm_id" {
  type    = number
  default = 1000
}
variable "c1_cp1_vm_name" {
  type    = string
  default = "c1-cp1"
}
variable "c1_cp1_vm_cpu_cores" {
  type    = number
  default = 2
}
variable "c1_cp1_vm_ram" {
  type    = number
  default = 2048
}
variable "c1_cp1_vm_target_node" {
  type        = string
  description = "Node to create the VM on"
  default     = "pve1-i7-64"
}

///////////////////

variable "c1_node1_vm_id" {
  type    = number
  default = 1001
}
variable "c1_node1_vm_name" {
  type    = string
  default = "c1-node1"
}
variable "c1_node1_vm_cpu_cores" {
  type    = number
  default = 2
}
variable "c1_node1_vm_ram" {
  type    = number
  default = 2048
}
variable "c1_node1_vm_target_node" {
  type        = string
  description = "Node to create the VM on"
  default     = "pve1-i7-64"
}

///////////////////

variable "c1_node2_vm_id" {
  type    = number
  default = 1002
}
variable "c1_node2_vm_name" {
  type    = string
  default = "c1-node2"
}
variable "c1_node2_vm_cpu_cores" {
  type    = number
  default = 2
}
variable "c1_node2_vm_ram" {
  type    = number
  default = 2048
}
variable "c1_node2_vm_target_node" {
  type        = string
  description = "Node to create the VM on"
  default     = "pve1-i7-64"
}

///////////////////

variable "c1_node3_vm_id" {
  type    = number
  default = 1003
}
variable "c1_node3_vm_name" {
  type    = string
  default = "c1-node3"
}
variable "c1_node3_vm_cpu_cores" {
  type    = number
  default = 2
}
variable "c1_node3_vm_ram" {
  type    = number
  default = 2048
}
variable "c1_node3_vm_target_node" {
  type        = string
  description = "Node to create the VM on"
  default     = "pve1-i7-64"
}