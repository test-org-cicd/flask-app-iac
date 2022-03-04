terraform {
  required_providers {
    external = {
      source = "hashicorp/external"
      version = "2.2.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.8.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

provider "external" {}

data "external" "aws_iam_authenticator" {
  program = ["bash", "${path.module}/authenticator.sh"]

  query = {
    cluster_name = "terraform-eks"
  }
}

provider "kubernetes" {
  token = "${data.external.aws_iam_authenticator.result.token}"
  config_path = "~/.kube/config"
}

provider "helm" {
   kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "null" {}
