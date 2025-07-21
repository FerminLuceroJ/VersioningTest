module "wrapper_documentdb" {
  source = "../../"

  metadata = local.metadata
  project  = local.project

  documentdb_parameters = {
    "00" = {
      subnets = data.aws_subnets.database.ids
      # vpc_name    = "" # Default: ${local.common_name} (dmc-prd)

      master_username = "master"
      master_password = "password"
      # Opcional: Por default abierto el puerto al CIDR de la VPC
      # ingress_with_cidr_blocks = [
      #   {
      #     rule        = "mongodb-27017-tcp"
      #     cidr_blocks = "0.0.0.0/0"
      #     description = "Enable all access"
      #   }
      # ]
      dns_records = {
        "" = {
          zone_name    = "${local.zone_public}"
          private_zone = false
        }
      }
    }
  }

  documentdb_defaults = var.documentdb_defaults
}