#
# IAM Instance Profile, for storing secrets in the Parameter Store
#


# https://www.terraform.io/docs/providers/aws/r/iam_role.html
resource "aws_iam_role" "iam_role_parameter_store" {
  name = "iam_role_parameter-store"
  path = "/tf/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
            "ec2.amazonaws.com",
            "ssm.amazonaws.com"
        ]
      }
    }
  ]
}
EOF
}

output "iam_role_parameter_store-id" {
  value = "${aws_iam_role.iam_role_parameter_store.unique_id}"
}
output "iam_role_parameter_store-arn" {
  value = "${aws_iam_role.iam_role_parameter_store.arn}"
}

output "iam_role_parameter_store-name" {
  value = "${aws_iam_role.iam_role_parameter_store.name}"
}



# https://www.terraform.io/docs/providers/aws/d/iam_policy_document.html
data "aws_iam_policy_document" "iam_policy_document_parameter_store" {

    statement {
        effect = "Allow"
        actions = [
             "resource-groups:*"
        ]
        resources = [
            "*"
        ]
    }
    
    statement {
        effect = "Allow"
        actions = [
             "kms:ListKeys",
             "kms:ListAliases"
        ]
        resources = [
            "*"
        ]
    }

    statement {
        effect = "Allow"
        actions = [
             "kms:Describe*",
             "kms:Decrypt"
        ]
        resources = [
            "${var.kms_key_parameter-store_arn}"
        ]
    }

    statement {
        effect = "Allow"
        actions = [
             "ssm:DescribeParameters",
             "ssm:UpdateInstanceInformation"
        ]
        resources = [
            "*"
        ]
    }

    statement {
        effect = "Allow"
        actions = [
             "ssm:Describe*",
             "ssm:Get*",
             "ssm:List*"
        ]
        resources = [
            "arn:aws:ssm:*:*:parameter/*"
        ]
    }
}

output "aws_iam_policy_document" {
  value = "${data.aws_iam_policy_document.iam_policy_document_parameter_store.json}"
}



# https://www.terraform.io/docs/providers/aws/r/iam_role_policy.html
resource "aws_iam_role_policy" "iam_policy_parameter_store" {
  name = "iam_parameter_store_policy"
  role = "${aws_iam_role.iam_role_parameter_store.id}"
  policy = "${data.aws_iam_policy_document.iam_policy_document_parameter_store.json}"
}

output "iam_policy_parameter_store-id" {
  value = "${aws_iam_role_policy.iam_policy_parameter_store.id}"
}

output "iam_policy_parameter_store-name" {
  value = "${aws_iam_role_policy.iam_policy_parameter_store.name}"
}



# https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html
resource "aws_iam_instance_profile" "iam_profile_parameter_store" {
  name  = "iam_profile_parameter_store"
  role = "${aws_iam_role.iam_role_parameter_store.name}"
}

output "iam_profile_parameter_store-id" {
  value = "${aws_iam_instance_profile.iam_profile_parameter_store.unique_id}"
}

output "iam_profile_parameter_store-arn" {
  value = "${aws_iam_instance_profile.iam_profile_parameter_store.arn}"
}

output "iam_profile_parameter_store-name" {
  value = "${aws_iam_instance_profile.iam_profile_parameter_store.name}"
}
