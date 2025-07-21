module "documentdb" {
  source = "../"

  create_enable       = true
  database_name       = local.common_name
  cluster_identifier  = local.common_name
  master_username     = "elusername"
  master_password     = "password!!QqQ"
  storage_encrypted   = "true"
  deletion_protection = "false"
  instance_class      = "db.r5.large"
  security_group_ids  = [aws_security_group.this.id]
  subnet_group_name   = "${local.common_name_prefix}-database"
  instances           = 2

  tags = local.common_tags
}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${local.common_name_prefix}"]
  }
}

resource "aws_security_group" "this" {
  name        = local.common_name
  description = local.common_name
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description = "TLS from VPC"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.this.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = local.common_tags
}
