output "web_vm_info" {
  description = "Information about web VM"
  value = {
    instance_name = yandex_compute_instance.vm-1.name
    hostname      = yandex_compute_instance.vm-1.hostname
    external_ip   = yandex_compute_instance.vm-1.network_interface[0].nat_ip_address
    internal_ip   = yandex_compute_instance.vm-1.network_interface[0].ip_address
    fqdn          = yandex_compute_instance.vm-1.fqdn
    zone          = yandex_compute_instance.vm-1.zone
    description   = yandex_compute_instance.vm-1.description
    labels        = yandex_compute_instance.vm-1.labels
  }
}

output "db_vm_info" {
  description = "Information about database VM"
  value = {
    instance_name = yandex_compute_instance.vm-2.name
    hostname      = yandex_compute_instance.vm-2.hostname
    external_ip   = yandex_compute_instance.vm-2.network_interface[0].nat_ip_address
    internal_ip   = yandex_compute_instance.vm-2.network_interface[0].ip_address
    fqdn          = yandex_compute_instance.vm-2.fqdn
    zone          = yandex_compute_instance.vm-2.zone
    description   = yandex_compute_instance.vm-2.description
    labels        = yandex_compute_instance.vm-2.labels
  }
}

output "all_vms_info" {
  description = "Information about all VMs"
  value = {
    web_vm = {
      name        = yandex_compute_instance.vm-1.name
      hostname    = yandex_compute_instance.vm-1.hostname
      external_ip = yandex_compute_instance.vm-1.network_interface[0].nat_ip_address
      internal_ip = yandex_compute_instance.vm-1.network_interface[0].ip_address
      fqdn        = yandex_compute_instance.vm-1.fqdn
      zone        = yandex_compute_instance.vm-1.zone
      role        = yandex_compute_instance.vm-1.labels["role"]
    }
    db_vm = {
      name        = yandex_compute_instance.vm-2.name
      hostname    = yandex_compute_instance.vm-2.hostname
      external_ip = yandex_compute_instance.vm-2.network_interface[0].nat_ip_address
      internal_ip = yandex_compute_instance.vm-2.network_interface[0].ip_address
      fqdn        = yandex_compute_instance.vm-2.fqdn
      zone        = yandex_compute_instance.vm-2.zone
      role        = yandex_compute_instance.vm-2.labels["role"]
    }
  }
}