resource "aws_security_group" "allow_all_traffic" {
  provider      = aws.aws_provider
  name          = "ec_sg"
  description   = "Allow all inbound and outbound traffic"
  vpc_id        = aws_vpc.qytang_vpc.id

  ingress {
    description = "all-traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec_sg"
  }
}

# ~~~~~~~~~~~获取ID的相关文章~~~~~~~~~~~~~~~~~~
# https://dev.classmethod.jp/articles/retrieve-latest-ami-id-of-amazonlinux-2023/

# 可以从参数存储中获取Amazon Linux 2 的最新 AMI ID
data aws_ssm_parameter amzn2_ami {
  provider      = aws.aws_provider
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# 获取Amazon Linux 2023 AMI ID
data "aws_ami" "amazonlinux_2023" {
  provider      = aws.aws_provider
  most_recent   = true
  owners        = [ "amazon" ]
  filter {
    name = "name"

    values = [ "al2023-ami-*-kernel-6.1-x86_64" ] # x86_64
    # values = [ "al2023-ami-*-kernel-6.1-arm64" ] # ARM
    # values = [ "al2023-ami-minimal-*-kernel-6.1-x86_64" ] # Minimal Image (x86_64)
    # values = [ "al2023-ami-minimal-*-kernel-6.1-arm64" ] # Minimal Image (ARM)
  }
}


resource "aws_instance" "ziti-controller" {
  provider              = aws.aws_provider
  key_name              = var.aws_region_key
  ami                   = data.aws_ami.amazonlinux_2023.id
  instance_type         = "t2.medium"
  subnet_id             = aws_subnet.qytang_subnet_1.id
  security_groups       = [aws_security_group.allow_all_traffic.id]
  tags = {
    Name = "ziti-controller"
  }
  
  user_data = file("${path.module}/user_data.sh")

}

# 关联一个 Elastic IP 到上面的 EC2 实例
resource "aws_eip" "ziti_controller_eip" {
  provider = aws.aws_provider
  instance = aws_instance.ziti-controller.id
  domain   = "vpc"
  tags = {
    Name = "ziti controller EIP"
  }
}


