# # # Generate private and corresponding public key
# # resource "tls_private_key" "ssh_key" {
# #   algorithm = local.ssh_key_algorithm
# #   rsa_bits  = local.ssh_key_rsa_bits
# # }

# # resource "null_resource" "setup_key_permissions" {
# #   provisioner "local-exec" {
# #     command = <<EOT
# #       chmod 770 test-key.pem
# #       echo "Permissions updated for test-key.pem"
# #       rm -f test-key.pem
# #       echo "test-key.pem has been deleted"
# #     EOT
# #   }
# # }

# # resource "local_file" "pem_file" {
# #   filename        = pathexpand("./${var.ejb_private_keyname}")
# #   file_permission = "400"
# #   content         = tls_private_key.ssh_key.private_key_pem
# # }

# # resource "aws_key_pair" "ej_key" {
# #   key_name   = local.ejb_key_name
# #   public_key = tls_private_key.ssh_key.public_key_openssh
# # }

# # # Webserver creation 
# # resource "aws_instance" "ejb-webserver" {
# #   ami               = local.ejb_ami_id
# #   instance_type     = local.ejb_instance_type
# #   availability_zone = local.ejb_availability_zone
# #   key_name          = aws_key_pair.ej_key.key_name # Use the public key for AWS EC2

# #   network_interface {
# #     device_index         = 0
# #     network_interface_id = aws_network_interface.ejb-web-server-nic.id
# #   }

# #   user_data = <<-EOF
# #                 #!/bin/bash
# #                 sudo apt update -y
# #                 sudo apt upgrade -y
# #                 sudo apt install nginx python3-certbot-nginx -y
# #                 sudo systemctl enable --now nginx
# #                 sudo bash -c 'echo your very first web server > /var/www/html/index.html'
# #                 EOF

# #   tags = {
# #     Name = local.ejb_webserver_name
# #   }
# # }



# # # Update Nginx Configuration and Enable HTTPS
# # resource "null_resource" "configure_nginx_https" {
# #   connection {
# #     type        = "ssh"
# #     host        = aws_instance.ejb-webserver.public_ip
# #     user        = "ubuntu"
# #     private_key = file(var.ejb_private_keyname)
# #     agent       = false
# #   }

# # ###############################3


# # Generate private and corresponding public key
# resource "tls_private_key" "ssh_key" {
#   algorithm = local.ssh_key_algorithm
#   rsa_bits  = local.ssh_key_rsa_bits
# }

# resource "local_file" "pem_file" {
#   filename        = pathexpand("./${var.ejb_private_keyname}")
#   file_permission = "400"
#   content         = tls_private_key.ssh_key.private_key_pem
# }

# resource "aws_key_pair" "ej_key" {
#   key_name   = local.ejb_key_name
#   public_key = tls_private_key.ssh_key.public_key_openssh
# }

# # Webserver creation
# resource "aws_instance" "ejb-webserver" {
#   ami               = local.ejb_ami_id
#   instance_type     = local.ejb_instance_type
#   availability_zone = local.ejb_availability_zone
#   key_name          = aws_key_pair.ej_key.key_name # Use the public key for AWS EC2

#   network_interface {
#     device_index         = 0
#     network_interface_id = aws_network_interface.ejb-web-server-nic.id
#   }

#   user_data = <<-EOF
#                 #!/bin/bash
#                 sudo apt update -y
#                 sudo apt upgrade -y
#                 sudo apt install nginx python3-certbot-nginx -y
#                 sudo systemctl enable --now nginx
#                 sudo bash -c 'echo your very first web server > /var/www/html/index.html'
#                 EOF

#   tags = {
#     Name = local.ejb_webserver_name
#   }
# }

# # Template for Nginx configuration
# data "template_file" "nginx_config" {
#   template = <<EOT
# server {
#     listen 80;
#     server_name ${var.domain_name};
#     return 301 https://\$host\$request_uri;
# }

# server {
#     listen 443 ssl;
#     server_name ${var.domain_name};

#     ssl_certificate /etc/letsencrypt/live/${var.domain_name}/fullchain.pem;
#     ssl_certificate_key /etc/letsencrypt/live/${var.domain_name}/privkey.pem;

#     ssl_protocols TLSv1.2 TLSv1.3;
#     ssl_ciphers HIGH:!aNULL:!MD5;

#     root /var/www/html;
#     index index.html;

#     location / {
#         try_files \$uri \$uri/ =404;
#     }
# }
# EOT
# }

# # Update Nginx Configuration and Enable HTTPS
# resource "null_resource" "configure_nginx_https" {
#   connection {
#     type        = "ssh"
#     host        = aws_instance.ejb-webserver.public_ip
#     user        = "ubuntu"
#     private_key = file(var.ejb_private_keyname)
#     agent       = false
#   }

#   provisioner "file" {
#     content     = data.template_file.nginx_config.rendered
#     destination = "/tmp/nginx_default.conf"
#   }

#   provisioner "remote-exec" {
#     inline = [

#       # Run Certbot to request SSL certificates
#       "sudo certbot certonly --nginx --agree-tos --register-unsafely-without-email -d ${var.domain_name} -v",

#       # Move the configuration file to the Nginx directory
#       "sudo mv /tmp/nginx_default.conf /etc/nginx/sites-available/default",

#       # Restart Nginx to apply the configuration
#       "sudo systemctl restart nginx",

#       # Reload Nginx to ensure SSL is applied
#       "sudo systemctl reload nginx"
#     ]
#   }

#   depends_on = [aws_instance.ejb-webserver, local_file.pem_file]
# }


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
  key_name          = aws_key_pair.ej_key.key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.ejb-web-server-nic.id
  }

  user_data = <<-EOF
                #!/bin/bash
                set -e

                # Update and upgrade packages
                sudo apt-get update -y || sudo apt update -y
                sudo apt-get upgrade -y || sudo apt upgrade -y

                # Install required packages
                sudo apt-get install -y nginx python3-certbot-nginx || sudo apt install -y nginx python3-certbot-nginx

                # Enable and start NGINX
                sudo systemctl enable --now nginx

                # Add default content
                echo "Your very first web server" | sudo tee /var/www/html/index.html
              EOF

  tags = {
    Name = local.ejb_webserver_name
  }
}

# Template for Nginx configuration
data "template_file" "nginx_config" {
  template = <<EOT
server {
    listen 80;
    server_name ${var.domain_name};
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name ${var.domain_name};

    ssl_certificate /etc/letsencrypt/live/tracker-db.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/tracker-db.com/privkey.pem;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOT
}

# Update Nginx Configuration and Enable HTTPS
resource "null_resource" "configure_nginx_https" {
  connection {
    type        = "ssh"
    host        = aws_instance.ejb-webserver.public_ip
    user        = "ubuntu"
    private_key = file(var.ejb_private_keyname)
    agent       = false

  }


  provisioner "file" {
    content     = data.template_file.nginx_config.rendered
    destination = "/tmp/nginx_default.conf"
  }

  provisioner "remote-exec" {
    inline = [

      # Wait for lock release
      "while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do echo 'Waiting for dpkg lock to be released...'; sleep 1; done",

      # Check for existing Certbot installation
      "if ! command -v certbot >/dev/null; then sudo apt-get install -y python3-certbot-nginx || sudo apt install -y python3-certbot-nginx; fi",

      # Run Certbot to request SSL certificates
      "sudo certbot certonly --nginx --non-interactive --agree-tos --register-unsafely-without-email -d ${var.domain_name} -v",

      # Move the Nginx configuration file
      "sudo mv /tmp/nginx_default.conf /etc/nginx/sites-available/default",

      # Test Nginx configuration
      "sudo nginx -t",

      # Restart Nginx to apply the configuration
      "sudo systemctl restart nginx",

      # Reload Nginx to ensure SSL is applied
      "sudo systemctl reload nginx"
    ]
  }

  depends_on = [aws_instance.ejb-webserver, local_file.pem_file]
}

