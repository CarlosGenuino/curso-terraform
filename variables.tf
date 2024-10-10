variable "prefix" {
  type        = string
  default     = "fullcyle"
  description = "prefixo dos recursos"
}

variable "cluster_name" {
  type        = string
  default     = "curso-terraform"
  description = "nome do cluster"
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "tempo de retenção em dias"
}

variable "desired_size" {
  type        = number
  default     = 2
  description = "quantidade de maquinas desejadas"
}
variable "max_size" {
  type        = number
  default     = 4
  description = "quantidade maxima de maquinas desejadas"
}
variable "min_size" {
  type        = number
  default     = 2
  description = "quantidade minima de maquinas desejadas"
}