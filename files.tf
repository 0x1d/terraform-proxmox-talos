# The image is generated on https://factory.talos.dev/ with QEMU guest addon enabled
resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  for_each                = toset(var.proxmox_nodes)
  content_type            = "iso"
  datastore_id            = "local"
  node_name               = each.value
  file_name               = "talos-v${var.talos_version}-nocloud-amd64.img"
  url                     = "https://factory.talos.dev/image/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515/v${var.talos_version}/nocloud-amd64.raw.gz"
  decompression_algorithm = "gz"
  overwrite               = false
}
