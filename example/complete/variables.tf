/*----------------------------------------------------------------------*/
/* Common |                                                             */
/*----------------------------------------------------------------------*/

# variable "metadata" {
#   type = any
# }

# variable "project" {
#   type = string
# }

/*----------------------------------------------------------------------*/
/* ALB | Variable Definition                                            */
/*----------------------------------------------------------------------*/

variable "documentdb_defaults" {
  description = "Maps of DOCDB to create a wrapper from. Values are passed through to the module."
  type        = any
  default     = {}
}

