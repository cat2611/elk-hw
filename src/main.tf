terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_vpc_network" "network-1" {
  name        = var.vpc_network_name
  description = "VPC network created by Terraform"
}

# Первая подсеть в зоне ru-central1-a (для web ВМ)
resource "yandex_vpc_subnet" "subnet-a" {
  name           = "${var.vpc_subnet_name}-a"
  description    = "Subnet in ${var.vm_web_zone}"
  zone           = var.vm_web_zone
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

# Вторая подсеть в зоне ru-central1-b (для db ВМ)
resource "yandex_vpc_subnet" "subnet-b" {
  name           = "${var.vpc_subnet_name}-b"
  description    = "Subnet in ${var.vm_db_zone}"
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

# Первая ВМ в зоне ru-central1-a
resource "yandex_compute_instance" "vm-1" {
  name        = local.web_vm_name
  description = local.web_vm_description
  platform_id = var.vm_web_platform_id
  zone        = var.vm_web_zone
  hostname    = local.web_vm_hostname

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_web_image_id
      size     = var.vms_resources["web"].hdd_size
      type     = var.vms_resources["web"].hdd_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
  }

  metadata = merge(var.vm_metadata, {
    ssh-keys = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  })

  labels = local.web_vm_labels

  allow_stopping_for_update = var.vm_web_allow_stopping_for_update
}

# Вторая ВМ  в зоне ru-central1-b
resource "yandex_compute_instance" "vm-2" {
  name        = local.db_vm_name
  description = local.db_vm_description
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone
  hostname    = local.db_vm_hostname

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_db_image_id
      size     = var.vms_resources["db"].hdd_size
      type     = var.vms_resources["db"].hdd_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat       = true
  }

  metadata = merge(var.vm_metadata, {
    ssh-keys = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  })

  labels = local.db_vm_labels

  allow_stopping_for_update = var.vm_db_allow_stopping_for_update
}