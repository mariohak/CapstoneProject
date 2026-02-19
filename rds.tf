resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-dbsubnets"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${var.project_name}-dbsubnets"
  }
}

resource "aws_db_instance" "mysql" {
  identifier         = "${var.project_name}-mysql"
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = var.db_instance_class

  allocated_storage  = 20
  storage_type       = "gp2"

  # Provider v3 uses 'name' for initial database name
  name               = var.db_name
  username           = var.db_username
  password           = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Sandbox-safe: default false (no standby)
  multi_az               = var.db_multi_az
  publicly_accessible    = false

  skip_final_snapshot    = true
  deletion_protection    = false
  apply_immediately      = true

  tags = {
    Name = "${var.project_name}-mysql"
  }
}
