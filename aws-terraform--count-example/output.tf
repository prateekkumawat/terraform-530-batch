output "firstinstance1eip" {
  value = ["${aws_instance.firstinstance.*.public_ip}"]
}