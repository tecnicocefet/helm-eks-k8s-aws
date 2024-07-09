resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.18.1-eksbuild.1" # Versão compatível com Kubernetes 1.29
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = module.eks.cluster_name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "core_dns" {
  cluster_name = module.eks.cluster_name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name             = module.eks.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = module.irsa_ebs_csi.iam_role_arn
  addon_version            = "v1.32.0-eksbuild.1" # Versão compatível com Kubernetes 1.29
}
