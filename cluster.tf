resource "talos_machine_secrets" "machine_secrets" {}

data "talos_client_configuration" "talosconfig" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoints            = [for config in var.talos_controlplane_config : config.ip]
}

data "talos_machine_configuration" "machineconfig_cp" {
  for_each         = { for machine in var.talos_controlplane_config : machine.name => machine }
  cluster_name     = var.cluster_name
  cluster_endpoint = "https://${each.value.ip}:6443"
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_machine_configuration_apply" "cp_config_apply" {
  for_each                    = { for machine in var.talos_controlplane_config : machine.name => machine }
  depends_on                  = [proxmox_virtual_environment_vm.talos_cp]
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_cp[each.value.name].machine_configuration
  node                        = each.value.ip
}

data "talos_machine_configuration" "machineconfig_worker" {
  for_each         = { for machine in var.talos_worker_config : machine.name => machine }
  cluster_name     = var.cluster_name
  cluster_endpoint = "https://${var.talos_controlplane_config[0].ip}:6443"
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_machine_configuration_apply" "worker_config_apply" {
  for_each                    = { for machine in var.talos_worker_config : machine.name => machine }
  depends_on                  = [proxmox_virtual_environment_vm.talos_worker]
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_worker[each.value.name].machine_configuration
  node                        = each.value.ip
}

resource "talos_machine_bootstrap" "bootstrap" {
  depends_on           = [talos_machine_configuration_apply.cp_config_apply]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = var.talos_controlplane_config[0].ip
}

data "talos_cluster_health" "health" {
  depends_on           = [talos_machine_configuration_apply.cp_config_apply, talos_machine_configuration_apply.worker_config_apply]
  client_configuration = data.talos_client_configuration.talosconfig.client_configuration
  control_plane_nodes  = [for config in var.talos_controlplane_config : config.ip]
  worker_nodes         = [for config in var.talos_worker_config : config.ip]
  endpoints            = data.talos_client_configuration.talosconfig.endpoints
}

resource "talos_cluster_kubeconfig" "kubeconfig" {
  depends_on           = [talos_machine_bootstrap.bootstrap, data.talos_cluster_health.health]
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = var.talos_controlplane_config[0].ip
}
