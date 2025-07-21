module "security_group_documentdb" {
  for_each = var.documentdb_parameters

  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name            = "${local.common_name}-documentdb-${each.key}"
  vpc_id          = data.aws_vpc.this[each.key].id
  use_name_prefix = false
  ingress_with_cidr_blocks = lookup(each.value, "ingress_with_cidr_blocks", [
    {
      rule        = "mongodb-27017-tcp"
      cidr_blocks = data.aws_vpc.this[each.key].cidr_block
    }
  ])

  tags = local.common_tags
}