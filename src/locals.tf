locals {

  web_vm_name = "${var.vm_web_name}-${var.vm_web_zone}-web"
  db_vm_name  = "${var.vm_db_name}-${var.vm_db_zone}-db"
  
  web_vm_hostname = "${var.vm_web_name}.${var.vm_web_zone}.internal"
  db_vm_hostname  = "${var.vm_db_name}.${var.vm_db_zone}.internal"
  
  common_labels = {
    environment = "dev"
    managed_by  = "terraform"
    project     = "netology"
  } 

  web_vm_labels = merge(local.common_labels, {
    role = "web"
    tier = "frontend"
  })
  
  db_vm_labels = merge(local.common_labels, {
    role = "database"
    tier = "backend"
  })
  
  web_vm_description = "Web server VM created by Terraform in ${var.vm_web_zone}"
  db_vm_description  = "Database VM created by Terraform in ${var.vm_db_zone}"
}