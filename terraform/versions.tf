terraform {
  required_version = ">=1.0.0, < 2"
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "=5.87.0"
    }
  }
}
