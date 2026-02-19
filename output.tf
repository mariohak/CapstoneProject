# This file defines the output values for the Terraform configuration,
# including the WordPress URL, public IP address of the EC2 instance, 
# and the RDS endpoint. These outputs provide important information 
# about the deployed infrastructure, allowing users to easily access 
# the WordPress application and connect to the RDS database.
# The RDS endpoint is marked as sensitive to protect it from being 
# displayed in plain text in the Terraform output, ensuring that 
# sensitive information is handled securely.    

output "wordpress_url" {
  value = "http://${aws_instance.wordpress.public_dns}"
}

output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
}

output "rds_endpoint" {
  value     = aws_db_instance.mysql.endpoint
  sensitive = true
}
