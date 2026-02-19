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
