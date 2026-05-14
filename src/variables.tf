variable "yandex_token" {
  description = "OAuth token for Yandex Cloud"
  type        = string
  sensitive   = true
}

variable "cloud_id" {
  description = "Yandex Cloud cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}

variable "zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}


variable "vpc_network_name" {
  description = "VPC network name"
  type        = string
  default     = "test-network"
}

variable "vpc_subnet_name" {
  description = "VPC subnet base name"
  type        = string
  default     = "test-subnet"
}

variable "vms_ssh_public_root_key" {
  description = "Path to SSH public key file"
  type        = string
  default     = "/home/lad/.ssh/id_rsa.pub"
}