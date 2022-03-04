resource "null_resource" "terraform-eks-aws-csi" {
  provisioner "local-exec" {
      command = "kubectl apply -k 'github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master'"
  }
}