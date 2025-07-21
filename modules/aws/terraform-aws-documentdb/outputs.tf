output "id" {
  value       = join("", aws_docdb_cluster.this.*.id)
  description = "The DocDB Cluster Identifier"
}

output "port" {
  value       = var.docdb_db_port
  description = "Port"
}

output "endpoint" {
  value       = concat(aws_docdb_cluster.this.*.endpoint, [""])[0]
  description = "The DNS address of the DocDB instance"
}

output "reader_endpoint" {
  value       = concat(aws_docdb_cluster.this.*.reader_endpoint, [""])[0]
  description = "The DNS address of the DocDB instance"
}

output "zone_id" {
  value       = concat(aws_docdb_cluster.this.*.hosted_zone_id, [""])[0]
  description = "The Route53 Hosted Zone ID of the endpoint"
}

output "arn" {
  value       = join("", aws_docdb_cluster.this.*.arn)
  description = "DocumentDB Replication Group ARN"
}
