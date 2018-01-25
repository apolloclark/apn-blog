#
# KMS outputs
#
output "kms_key_parameter-store_id" {
  value = "${aws_kms_key.kms_key_parameter-store.key_id}"
}

output "kms_key_parameter-store_arn" {
  value = "${aws_kms_key.kms_key_parameter-store.arn}"
}