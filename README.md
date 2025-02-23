# Terraform Proxmox Talos

This Terraform module provisions a [Talos Linux](https://www.talos.dev/) cluster on a [Proxmox Virtual Environment](https://www.proxmox.com/).  
It is is based on a greate article by [Olav S. Thoresen: Talos cluster on Proxmox with Terraform](https://olav.ninja/talos-cluster-on-proxmox-with-terraform).  
In addition to the configuration provided by the article, this module enables you to provision a HA control plane and any number of worker nodes.  

## Setup

Configure `.env`:
```shell
export PROXMOX_VE_USERNAME="root@pam"
export PROXMOX_VE_PASSWORD="super-secure-password"
export PROXMOX_VE_ENDPOINT="https://<proxmox-ip>:8006/"
```

Apply configuration:
```
terraform apply
```

Write Kubeconfig (caution, this will override you existing Kubeconfig):
```
terraform output -raw kubeconfig > ~/.kube/config
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.72.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.72.0 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.talos_nocloud_image](https://registry.terraform.io/providers/bpg/proxmox/0.72.0/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_vm.talos_cp](https://registry.terraform.io/providers/bpg/proxmox/0.72.0/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.talos_worker](https://registry.terraform.io/providers/bpg/proxmox/0.72.0/docs/resources/virtual_environment_vm) | resource |
| [talos_cluster_kubeconfig.kubeconfig](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/resources/cluster_kubeconfig) | resource |
| [talos_machine_bootstrap.bootstrap](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.cp_config_apply](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.worker_config_apply](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.machine_secrets](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/resources/machine_secrets) | resource |
| [talos_client_configuration.talosconfig](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/data-sources/client_configuration) | data source |
| [talos_cluster_health.health](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/data-sources/cluster_health) | data source |
| [talos_machine_configuration.machineconfig_cp](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/data-sources/machine_configuration) | data source |
| [talos_machine_configuration.machineconfig_worker](https://registry.terraform.io/providers/siderolabs/talos/0.7.1/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `"homelab"` | no |
| <a name="input_default_gateway"></a> [default\_gateway](#input\_default\_gateway) | n/a | `string` | `"192.168.1.1"` | no |
| <a name="input_proxmox_nodes"></a> [proxmox\_nodes](#input\_proxmox\_nodes) | Names of the Proxmox nodes, used to download and reference node images | `list(string)` | <pre>[<br/>  "ms-01"<br/>]</pre> | no |
| <a name="input_talos_controlplane_config"></a> [talos\_controlplane\_config](#input\_talos\_controlplane\_config) | Machine configuration of control-plane nodes | <pre>list(object({<br/>    id        = number<br/>    ip        = string<br/>    name      = string<br/>    node      = string<br/>    cpu_cores = number<br/>    memory    = number<br/>    disk_size = number<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cpu_cores": 2,<br/>    "disk_size": 20,<br/>    "id": 101,<br/>    "ip": "192.168.1.181",<br/>    "memory": 2048,<br/>    "name": "talos-cp-01",<br/>    "node": "ms-01"<br/>  },<br/>  {<br/>    "cpu_cores": 2,<br/>    "disk_size": 20,<br/>    "id": 102,<br/>    "ip": "192.168.1.182",<br/>    "memory": 2048,<br/>    "name": "talos-cp-02",<br/>    "node": "ms-01"<br/>  },<br/>  {<br/>    "cpu_cores": 2,<br/>    "disk_size": 20,<br/>    "id": 103,<br/>    "ip": "192.168.1.183",<br/>    "memory": 2048,<br/>    "name": "talos-cp-03",<br/>    "node": "ms-01"<br/>  }<br/>]</pre> | no |
| <a name="input_talos_version"></a> [talos\_version](#input\_talos\_version) | n/a | `string` | `"1.9.4"` | no |
| <a name="input_talos_worker_config"></a> [talos\_worker\_config](#input\_talos\_worker\_config) | Machine configuration of worker nodes | <pre>list(object({<br/>    id        = number<br/>    ip        = string<br/>    name      = string<br/>    node      = string<br/>    cpu_cores = number<br/>    memory    = number<br/>    disk_size = number<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cpu_cores": 4,<br/>    "disk_size": 100,<br/>    "id": 111,<br/>    "ip": "192.168.1.191",<br/>    "memory": 4096,<br/>    "name": "talos-worker-01",<br/>    "node": "ms-01"<br/>  },<br/>  {<br/>    "cpu_cores": 4,<br/>    "disk_size": 100,<br/>    "id": 112,<br/>    "ip": "192.168.1.192",<br/>    "memory": 4096,<br/>    "name": "talos-worker-02",<br/>    "node": "ms-01"<br/>  },<br/>  {<br/>    "cpu_cores": 4,<br/>    "disk_size": 100,<br/>    "id": 113,<br/>    "ip": "192.168.1.193",<br/>    "memory": 4096,<br/>    "name": "talos-worker-03",<br/>    "node": "ms-01"<br/>  },<br/>  {<br/>    "cpu_cores": 4,<br/>    "disk_size": 100,<br/>    "id": 114,<br/>    "ip": "192.168.1.194",<br/>    "memory": 4096,<br/>    "name": "talos-worker-04",<br/>    "node": "ms-01"<br/>  }<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | n/a |
| <a name="output_talosconfig"></a> [talosconfig](#output\_talosconfig) | n/a |
