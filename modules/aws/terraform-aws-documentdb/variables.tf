/*----------------------------------------------------------------------*/
/* Region | Variable Definition                                         */
/*----------------------------------------------------------------------*/

variable "create_enable" {
  type        = bool
  description = "Set to create elasticache cluster"
  default     = true
}

variable "cluster_identifier" {
  type        = string
  description = "Cluster identifier"
  default     = ""
}
variable "docdb_engine" {
  type        = string
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster. Defaults to `docdb`. Valid values: `docdb`"
}

variable "docdb_engine_version" {
  type        = string
  default     = "4.0.0"
  description = "The version number of the database engine to use"
}

variable "database_name" {
  type        = string
  description = "Name of the default database"
}


variable "storage_encrypted" {
  type        = bool
  description = "Is storage encrypted?"
  default     = true
}


variable "master_username" {
  type        = string
  description = "master username"
}

variable "master_password" {
  type        = string
  description = "master password"
}

variable "db_retention_period" {
  type        = number
  description = "Number of days to retain backups for"
  default     = 1
}

variable "db_snapshot_window" {
  type        = string
  default     = "20:00-21:59"
  description = "Daily time range during which the backups happen"
}

variable "db_maintenance_window" {
  type        = string
  default     = "Mon:22:00-Mon:23:00"
  description = "The window to perform maintenance in. Syntax: `ddd:hh24:mi-ddd:hh24:mi`."
}

variable "final_snapshot_identifier" {
  type        = string
  description = "Identifier for primary final snapshot"
  default     = ""
}

variable "db_skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  default     = true
}

variable "subnets" {
  description = "A list of subnets to create subnetgroup. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = null
}

variable "cluster_parameters" {
  description = "A list of cluster parameters (map) to apply"
  type        = list(map(string))
  default = [
    {
      name  = "tls"
      value = "disabled"
    }
  ]
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "instances" {
  type        = number
  description = "Quantity of replicas in primary region cluster"
  default     = 0
}

variable "tags" {
  description = "Tags"
  type        = any
  default     = {}
}

variable "cluster_parameter_group_name" {
  type        = string
  description = "(optional)  Cluster parameter group name"
  default     = ""
}

/*----------------------------------------------------------------------*/
/* General | Variable Definition                                        */
/*----------------------------------------------------------------------*/

variable "deletion_protection" {
  type        = bool
  description = "A value that indicates whether the DB cluster has deletion protection enabled"
  default     = false
}

variable "docdb_db_port" {
  type        = number
  default     = 27017
  description = "docdb port"
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = ["audit", "profiler"]
  description = "Enabled cloudwatch logs exports"
}

variable "cluster_family" {
  type        = string
  default     = "docdb4.0"
  description = "The family of the docdb cluster parameter group. For more details, see https://docs.aws.amazon.com/docdb/latest/developerguide/db-cluster-parameter-group-create.html"
}

variable "instance_class" {
  type        = string
  description = "The instance class to use. For more details, see https://docs.aws.amazon.com/docdb/latest/developerguide/db-instance-classes.html#db-instance-class-specs"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Specifies whether any minor engine upgrades will be applied automatically to the DB instance during the maintenance window or not"
  default     = true
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}
