module "talos_cluster" {
  source          = "../../"
  cluster_name    = "homelab"
  talos_version   = "1.9.4"
  default_gateway = "192.168.1.1"
  proxmox_nodes   = ["ms-01"]
  talos_controlplane_config = [{
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
  talos_worker_config = [{
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
output "kubeconfig" {
  value     = module.talos_cluster.kubeconfig
  sensitive = true
}
