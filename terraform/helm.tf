# ఇక్కడ ఎటువంటి కాన్ఫిగరేషన్ అవసరం లేదు, ఇది డెఫాల్ట్ కుబెర్నెటిస్ ప్రొవైడర్ ని వాడుకుంటుంది
provider "helm" {
  # ఖాళీగా వదిలేయండి
}

resource "helm_release" "aws_lb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.lb_controller_role.iam_role_arn
  }
}