resource "aws_vpc" "new_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name      = "${var.prefix}-vpc"
    IAC       = true
    workspace = terraform.workspace
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "new_subnets" {
  count                   = 2
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name      = "${var.prefix}-subnet-${count.index}"
    IAC       = true
    workspace = terraform.workspace
  }
  depends_on = [
    aws_vpc.new_vpc
  ]
}

resource "aws_internet_gateway" "new_igw" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name      = "${var.prefix}-igw"
    IAC       = true
    workspace = terraform.workspace
  }
}

resource "aws_route_table" "new_rtb" {
  vpc_id = aws_vpc.new_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new_igw.id
  }
  tags = {
    Name      = "${var.prefix}-rtb"
    IAC       = true
    workspace = terraform.workspace
  }
}

resource "aws_route_table_association" "new_rtb_association" {
  count          = 2
  route_table_id = aws_route_table.new_rtb.id
  subnet_id      = aws_subnet.new_subnets.*.id[count.index]
}