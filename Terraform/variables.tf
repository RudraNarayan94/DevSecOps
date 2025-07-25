variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "Currency-Converter"
}

variable "github_token" {
  type        = string
  description = "GitHub PAT with repo access"
}

variable "github_owner" {
  type        = string
  description = "GitHub user/org"
}

variable "github_repo" {
  type        = string
  description = "GitHub repo name"
}

variable "github_branch" {
  default = "main"
}

variable "bucket_name" {
  type = string
}

variable "ami_id" {
  default = "ami-0e670eb768a5fc3d4" # Amazon Linux 2023 in ap-south-1
}


variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "instance_tag_key" {
  default = "Name"
}

variable "instance_tag_value" {
  default = "webserver"
}
