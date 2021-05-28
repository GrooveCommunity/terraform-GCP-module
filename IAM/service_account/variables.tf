variable "client" {
  type = string

  description =  <<EOF
Insira o Cliente
EOF
}

variable "gcp_project_id" {
  type = string

  description = <<EOF
Insira o ID do projeto
EOF
}

variable "cluster_name" {
  type = string

  description = <<EOF
Insira o nome do Cluster
EOF
}

variable "access_private_images" {
  type    = bool
  default = false


}

variable "service_account_project" {
  type        = string
  description = "Insira o ID do projeto do service account"
}