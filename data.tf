# This data source retrieves the AMI ID for the latest Amazon Linux 2 AMI, 
# which is commonly used for EC2 instances. By using this data source,
# you can ensure that your infrastructure always uses the most up-to-date 
# Amazon Linux 2 AMI without hardcoding the AMI ID in your Terraform configuration.

data "aws_ssm_parameter" "al2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}
