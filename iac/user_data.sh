#!/bin/bash

# 创建日志文件
exec > >(tee /var/log/user-data.log) 2>&1
echo "开始执行用户数据脚本: $(date)"

# 激活ssh root密码登录
echo "配置SSH..."
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
sed -i "s/UsePAM yes/UsePAM no/g" /etc/ssh/sshd_config
> ~/.ssh/authorized_keys
sudo sh -c 'echo root:Cisc0123 | chpasswd'
service sshd restart
echo "SSH配置完成"

sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

sudo mkdir -p /usr/local/lib/docker/cli-plugins/
sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
