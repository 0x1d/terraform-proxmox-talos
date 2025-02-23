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