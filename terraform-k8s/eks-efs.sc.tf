resource "kubernetes_storage_class_v1" "terraform-eks-efs-sc" {
  metadata {
    name = "efs-sc"
  }
  storage_provisioner = "efs.csi.aws.com"
}

resource "kubernetes_persistent_volume" "terraform-eks-efs-pv" {
  metadata {
    name = "efs-pv"
  }
  spec {
    capacity = {
      storage                        = "5Gi"
    }
    volume_mode                       = "Filesystem"
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "${kubernetes_storage_class_v1.terraform-eks-efs-sc.metadata[0].name}"
    persistent_volume_source {
      csi {
          driver = "efs.csi.aws.com"
          volume_handle = var.file_system_id
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "terraform-eks-efs-claim" {
  metadata {
    name = "efs-claim"
    namespace = "${kubernetes_namespace_v1.jenkins-namespace.metadata[0].name}"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    storage_class_name = "${kubernetes_storage_class_v1.terraform-eks-efs-sc.metadata[0].name}"
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }

  depends_on = [
    kubernetes_persistent_volume.terraform-eks-efs-pv,
  ]
}

