#
# IAM outputs
#
output "aws_iam_policy_document" {
  value = "${data.aws_iam_policy_document.parameter-store.json}"
}