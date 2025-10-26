variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type = string
  description = "Nome do bucket (deve ser globalmente único). Use vazio para sufixo aleatório."
  default = ""
}
