# Generate private and corresponding public key
resource "tls_private_key" "ssh_key" {
  algorithm = local.ssh_key_algorithm
  rsa_bits  = local.ssh_key_rsa_bits
}

resource "local_file" "pem_file" {
  filename        = pathexpand("./${var.ejb_private_keyname}")
  file_permission = "400"
  content         = tls_private_key.ssh_key.private_key_pem
}

resource "aws_key_pair" "ej_key" {
  key_name   = local.ejb_key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Webserver creation 
resource "aws_instance" "ejb-webserver" {
  ami               = local.ejb_ami_id
  instance_type     = local.ejb_instance_type
  availability_zone = local.ejb_availability_zone
  key_name          = aws_key_pair.ej_key.key_name # Use the public key for AWS EC2

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.ejb-web-server-nic.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt upgrade -y
                sudo apt install nginx python3-certbot-nginx -y
                sudo systemctl enable --now nginx
                sudo bash -c 'echo your very first web server > /var/www/html/index.html'
                EOF

  tags = {
    Name = local.ejb_webserver_name
  }
}

# SSL Cert request
resource "null_resource" "provision_openvpn" {
  connection {
    type        = "ssh"
    host        = aws_instance.ejb-webserver.public_ip
    user        = local.ejb_key_name
    private_key = file(var.ejb_private_keyname)
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      "sudo certbot certonly --nginx --agree-tos --register-unsafely-without-email -d ${var.domain_name}"
    ]
  }

  depends_on = [local_file.pem_file, cloudflare_record.tracker-db-root]
}
