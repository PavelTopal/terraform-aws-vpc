# Create a VPC
resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnets" {
  depends_on = [ # Explicit dependency 
    aws_vpc.example
  ]
  vpc_id = aws_vpc.example.id
  cidr_block  = "10.0.1.0/24"
  aws_availability_zones = data.aws_availability_zones.available.name[0]
}

resource "aws_iam_user" "lb" {
    for_each = toset(var.users)
    name = each.value
    tags = var.tags
}

 
 variable users{
    type = list
    description = "plwase supply name of the users"
    default = [
        "bob1",
        "sam1",
        "lisa1",
    ]
 }

output list_of_users {
    value = <<EOF


        Today you have created the following users


                "${aws_iam_user.lb["bob1"].arn}"




    EOF
}