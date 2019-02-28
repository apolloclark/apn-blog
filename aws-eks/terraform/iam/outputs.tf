#
# IAM outputs
#
output "aws_iam_policy_document" {
  value = "${data.aws_iam_policy_document.iam_policy_document_parameter_store.json}"
}