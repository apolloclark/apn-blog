# https://www.terraform.io/docs/providers/aws/r/eks_cluster.html
resource "aws_eks_cluster" "demo" {
  name            = "${var.cluster_name}"
  role_arn        = "${var.iam_role_parameter_store-arn}"

  vpc_config {
    subnet_ids         = ["${var.public_subnet_ids}"]
    security_group_ids = ["${var.security_group_ids}"]
  }
}