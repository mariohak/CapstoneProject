// This file defines the EC2 instance for the WordPress application, 
// including its configuration and user data script.

locals {
  rds_host = replace(aws_db_instance.mysql.endpoint, ":3306", "")
}

// Create an EC2 instance for the WordPress application

resource "aws_instance" "wordpress" {
  ami                         = data.aws_ssm_parameter.al2_ami.value
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.wordpress.id]
  key_name                    = var.key_pair_name

// Use a user data script to install and configure WordPress on the EC2 instance


  user_data = templatefile("${path.module}/userdata/wordpress.sh.tpl", {
  DB_HOST = local.rds_host
  DB_NAME = var.db_name
  DB_USER = var.db_username
  DB_PASS = var.db_password
})

  tags = {
    Name = "${var.project_name}-wp"
  }
}
