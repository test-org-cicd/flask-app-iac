resource "kubernetes_namespace_v1" "jenkins-namespace" {
  metadata {
    annotations = {
      name = "jenkins"
    }

    labels = {
      name = "terraform-eks-jenkins-ns"
    }
    
    name = "jenkins"
  }
}