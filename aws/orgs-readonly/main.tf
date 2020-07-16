module "labels" {
  source      = "../../common/tags/"
  namespace   = var.namespace
  sysenv      = var.sysenv
  environment = var.environment
  service     = local.service
  team_email  = var.team_email
}

locals {
  service = "ORGSReadOnlyTrust"
  tags    = merge(module.labels.tags, var.tags)
}

data "aws_iam_policy_document" "this" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:${var.aws_identity_partition}:iam::${var.child_account_id}:role/${var.child_account_role_name}"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = local.service
  path               = "/"
  tags               = local.tags
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:${var.aws_identity_partition}:iam::aws:policy/AWSOrganizationsReadOnlyAccess"
}
