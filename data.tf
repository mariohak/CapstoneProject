// Fetch the latest Amazon Linux 2 AMI ID from AWS Systems Manager Parameter Store

data "aws_ssm_parameter" "al2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}
