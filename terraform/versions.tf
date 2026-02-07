
terraform {
  required_version = ">= 1.14.0"

  required_providers {

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>1.31"
    }

    helm = {
      source  = "hashicopr/helm"
      version = "~>3.17.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~2.6.0"
    }
  }
}
