module "labels" {
  source      = "../../common/tags/"
  namespace   = var.namespace
  sysenv      = var.sysenv
  environment = var.environment
  service     = local.service
  team_email  = var.team_email
}

locals {
  service   = "workspaces_DefaultRole"
  base_name = join("-", [var.environment, local.service])
  tags      = merge(module.labels.tags, var.tags)
}

data "aws_iam_policy_document" "allow_workspaces_service" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["workspaces.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = local.service
  path               = "/"
  tags               = local.tags
  assume_role_policy = data.aws_iam_policy_document.allow_workspaces_service.json
}

resource "aws_iam_role_policy_attachment" "AmazonWorkSpacesServiceAccess" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesServiceAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonWorkSpacesSelfServiceAccess" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonWorkSpacesSelfServiceAccess"
}
