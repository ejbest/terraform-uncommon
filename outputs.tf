# outputs file
# using a format that helps for clarity 

output "server_private_ip___________" { value = aws_instance.ejb-webserver.private_ip }
output "server_public_dns___________" { value = aws_eip.one.public_dns }
output "server_public_ip1___________" { value = aws_eip.one.public_ip }
output "server_public_ip2___________" { value = aws_instance.ejb-webserver.public_ip }
output "server_id___________________" { value = aws_instance.ejb-webserver.id }

output "zssh_command" {
  value = "\n\nssh -i ${var.ejb_private_keyname} ubuntu@${aws_eip.one.public_dns}\n\n"
}

output "key" {
  value = var.ejb_private_keyname
}

output "zbrowser" {
  value = "\n\nhttp://${aws_eip.one.public_ip}\n\n"
}

output "ej-pem-private-key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}



