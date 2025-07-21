/*----------------------------------------------------------------------*/
/* DocumentDB | cluster                                                 */
/*----------------------------------------------------------------------*/

resource "aws_docdb_cluster" "this" {
  count                           = local.condition_create_enable
  global_cluster_identifier       = null
  cluster_identifier              = var.cluster_identifier
  master_username                 = var.master_username
  master_password                 = var.master_password
  backup_retention_period         = var.db_retention_period
  preferred_backup_window         = var.db_snapshot_window
  preferred_maintenance_window    = var.db_maintenance_window
  final_snapshot_identifier       = local.final_snapshot_identifier
  skip_final_snapshot             = var.db_skip_final_snapshot
  deletion_protection             = var.deletion_protection
  apply_immediately               = var.apply_immediately
  storage_encrypted               = var.storage_encrypted
  port                            = var.docdb_db_port
  vpc_security_group_ids          = var.security_group_ids
  db_subnet_group_name            = join("", aws_docdb_subnet_group.this.*.name)
  db_cluster_parameter_group_name = try(aws_docdb_cluster_parameter_group.this[0].name, var.cluster_parameter_group_name, null)
  engine                          = var.docdb_engine
  engine_version                  = var.docdb_engine_version
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags                            = var.tags
  depends_on = [
    aws_docdb_cluster_parameter_group.this
  ]
}

#hacer un submodulo para poder crear de forma independiente las instancias que requiera.
resource "aws_docdb_cluster_instance" "this" {
  count                      = local.condition_create_instances
  identifier                 = "${var.cluster_identifier}-${count.index}"
  engine                     = "docdb"
  cluster_identifier         = aws_docdb_cluster.this[0].id
  apply_immediately          = var.apply_immediately
  instance_class             = var.instance_class
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  tags                       = var.tags
}

#subnet group
resource "aws_docdb_subnet_group" "this" {
  count       = local.condition_create_enable
  name        = var.cluster_identifier
  description = "Allowed subnets for DB cluster instances"
  subnet_ids  = var.subnets
  tags        = var.tags
}

#reutilizar el recurso para poder crear uno o dos parameter groups deacuerdo a si es multi region o no
resource "aws_docdb_cluster_parameter_group" "this" {
  count       = local.condition_create_parameter_group
  name        = var.cluster_identifier
  description = "Parameter group for Aurora cluster (${var.cluster_identifier})"
  family      = "docdb4.0"

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }
  tags = var.tags
}
