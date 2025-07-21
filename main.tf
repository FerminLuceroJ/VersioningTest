module "documentdb" {
  for_each            = var.documentdb_parameters
  source              = "./modules/aws/terraform-aws-documentdb"
  create_enable       = true
  database_name       = "${local.common_name}-${each.key}"
  cluster_identifier  = "${local.common_name}-${each.key}"
  master_username     = lookup(each.value, "master_username")
  master_password     = lookup(each.value, "master_password")
  storage_encrypted   = lookup(each.value, "storage_encrypted", "true")
  deletion_protection = lookup(each.value, "deletion_protection", "true")
  instance_class      = lookup(each.value, "instance_class", "db.t3.medium")
  security_group_ids  = [module.security_group_documentdb[each.key].security_group_id]
  subnets             = lookup(each.value, "subnets", null)
  instances           = lookup(each.value, "instances", 1)

  tags = local.common_tags
}