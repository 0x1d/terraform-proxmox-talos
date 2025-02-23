variable "cluster_name" {
  type    = string
  default = "homelab"
}
variable "talos_version" {
  type    = string
  default = "1.9.4"
}
variable "default_gateway" {
  type    = string
  default = "192.168.1.1"
}

variable "proxmox_nodes" {
  description = "Names of the Proxmox nodes, used to download and reference node images"
  type        = list(string)
  default     = ["ms-01"]
}

variable "talos_controlplane_config" {
  description = "Machine configuration of control-plane nodes"
  type = list(object({
    id        = number
    ip        = string
    name      = string
    node      = string
    cpu_cores = number
    memory    = number
    disk_size = number
  }))
  default = [{
    id        = 101
    name      = "talos-cp-01"
    ip        = "192.168.1.181"
    node      = "ms-01"
    cpu_cores = 2
    memory    = 2048
    disk_size = 20
    }, {
    id        = 102
    name      = "talos-cp-02"
    ip        = "192.168.1.182"
    node      = "ms-01"
    cpu_cores = 2
    memory    = 2048
    disk_size = 20
    }, {
    id        = 103
    name      = "talos-cp-03"
    ip        = "192.168.1.183"
    node      = "ms-01"
    cpu_cores = 2
    memory    = 2048
    disk_size = 20
  }]
}

variable "talos_worker_config" {
  description = "Machine configuration of worker nodes"
  type = list(object({
    id        = number
    ip        = string
    name      = string
    node      = string
    cpu_cores = number
    memory    = number
    disk_size = number
  }))
  default = [{
    id        = 111
    name      = "talos-worker-01"
    ip        = "192.168.1.191"
    node      = "ms-01"
    cpu_cores = 4
    memory    = 4096
    disk_size = 100
    }, {
    id        = 112
    name      = "talos-worker-02"
    ip        = "192.168.1.192"
    node      = "ms-01"
    cpu_cores = 4
    memory    = 4096
    disk_size = 100
    }, {
    id        = 113
    name      = "talos-worker-03"
    ip        = "192.168.1.193"
    node      = "ms-01"
    cpu_cores = 4
    memory    = 4096
    disk_size = 100
    }, {
    id        = 114
    name      = "talos-worker-04"
    ip        = "192.168.1.194"
    node      = "ms-01"
    cpu_cores = 4
    memory    = 4096
    disk_size = 100
  }]
}
