#
# Parameter Store values
#
# https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html
resource "aws_ssm_parameter" "database_password" {
  name      = "/rds/database_password"
  type      = "SecureString"
  value     = "${var.database_password}"
  key_id    = "${var.kms_key_parameter-store_id}"
  overwrite = true
}
