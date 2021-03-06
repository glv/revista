variable "env" {
  type        = "string"
  description = "Environment name"
  default     = "prod"
}

variable "name_prefix" {
  type        = "string"
  description = "Prefix for naming resources"
  default     = "rv-prod-web"
}

variable "aws_role_arn" {
  type        = "string"
  description = "AWS ARN for role to assume"
  default     = "arn:aws:iam::584964217758:role/OrganizationAccountAccessRole"
}
