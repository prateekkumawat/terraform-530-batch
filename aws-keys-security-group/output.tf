output "firstinstanceiip" {
  value = aws_instance.firstinstance.private_ip
}

output "firstinstnacepip" {
  value = aws_instance.firstinstance.public_ip
}

output "firstinstancedns" {
  value = aws_instance.firstinstance.public_dns
}

output "firstinstanceprivatedns" {
  value = aws_instance.firstinstance.private_dns
}