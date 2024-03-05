output "bastion_instance_id" {
  value = aws_instance.bastion.id
}

output "private_instance_id" {
  value = aws_instance.private_instance.id
}

output "key_pair_name" {
  value = aws_key_pair.ssh_key.key_name
}