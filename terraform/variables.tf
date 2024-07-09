variable "region" {
  description = "Região da AWS onde o cluster EKS será criado"
  type        = string
  default     = "us-east-1"
}

variable "cluster_enabled_log_types" {
  description = "Tipos de logs do plano de controle do EKS que serão habilitados"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "Lista de blocos CIDR permitidos para acesso público ao endpoint do cluster"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "eks_version" {
  description = "Versão do Amazon EKS"
  type        = string
  default     = "1.22"
}

variable "cluster_name" {
  description = "Nome do cluster EKS na AWS"
  type        = string
  default     = "cluster-eks-tcc"
}

### Add-ons
variable "version_kube_proxy" {
  description = "Versão do Kube-Proxy"
  type        = string
  default     = "v1.22.2"
}

variable "version_coredns" {
  description = "Versão do CoreDNS"
  type        = string
  default     = "v1.8.4"
}

variable "version_vpc_cni" {
  description = "Versão do VPC-CNI"
  type        = string
  default     = "v1.8.0"
}

variable "version_ebs_csi" {
  description = "Versão do EBS-CSI"
  type        = string
  default     = "v0.10.0"
}

## VPC
variable "cidr" {
  description = "Bloco CIDR da VPC que será criada para o cluster EKS"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway nas sub-redes públicas da VPC"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Utilizar um único NAT Gateway para todas as sub-redes privadas"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar nomes de host DNS na VPC"
  type        = bool
  default     = true
}

variable "eks_cluster_created" {
  type    = bool
  default = false
}

variable "namespace" {
  type    = string
  default = "dev"
}


