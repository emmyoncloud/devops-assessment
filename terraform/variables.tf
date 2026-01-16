variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "devops-app"
}

variable "container_port" {
  default = 3000
}

variable "image_url" {
  description = "Docker image from Amazon ECR"
}
