resource "proxmox_virtual_environment_vm" "talos_cp" {
  for_each    = { for machine in var.talos_controlplane_config : machine.name => machine }
  name        = each.value.name
  node_name   = each.value.node
  vm_id       = each.value.id
  description = "Managed by Terraform"
  tags        = ["terraform"]
  on_boot     = true

  cpu {
    cores = each.value.cpu_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image[each.value.node].id
    file_format  = "raw"
    interface    = "virtio0"
    size         = each.value.disk_size
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.default_gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "talos_worker" {
  for_each    = { for machine in var.talos_worker_config : machine.name => machine }
  depends_on  = [proxmox_virtual_environment_vm.talos_cp]
  name        = each.value.name
  node_name   = each.value.node
  vm_id       = each.value.id
  description = "Managed by Terraform"
  tags        = ["terraform"]
  on_boot     = true

  cpu {
    cores = each.value.cpu_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.memory
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image[each.value.node].id
    file_format  = "raw"
    interface    = "virtio0"
    size         = each.value.disk_size
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.default_gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }
  }
}
