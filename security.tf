# This file defines the security groups for the WordPress application and RDS database.
# It creates a security group for the WordPress EC2 instance that allows HTTP and SSH access 
# from specified sources. It also creates a security group for the RDS database that allows
# MySQL access only from the WordPress security group. This setup ensures that the EC2
# instance can communicate with the RDS database securely while restricting access to the
# database to only the WordPress instance. 

resource "aws_security_group" "wordpress" {
  name        = "${var.project_name}-wp-sg"
  description = "WordPress EC2 SG"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH (restrict to your IP if possible)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-wp-sg"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "RDS MySQL SG"
  vpc_id      = aws_vpc.this.id

  # MySQL ingress added as separate rule to reference WP SG
  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

resource "aws_security_group_rule" "rds_mysql_from_wp" {
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.wordpress.id
  description              = "MySQL from WordPress SG only"
}
