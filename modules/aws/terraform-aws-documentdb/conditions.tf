locals {

  condition_create_enable = var.create_enable ? 1 : 0

  condition_create_instances       = var.instances != 0 ? var.instances : 0
  condition_create_parameter_group = var.cluster_parameters != "" ? 1 : 0
  final_snapshot_identifier        = var.final_snapshot_identifier != "" ? var.final_snapshot_identifier : null

}
