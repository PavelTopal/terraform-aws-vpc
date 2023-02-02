output "info" {
  value = aws_vpc.example.default_security_group_id
}
output "azs" {
  value = data.aws_availability_zones.available.id
}