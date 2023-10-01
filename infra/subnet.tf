### Subnets ###

# Fetch AZs in the current region
data "aws_availability_zones" "available" {}

#Create public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count = var.az_count
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 11)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet-${format("%03d", count.index + 1)}"
    Environment = var.environment
  }
}

#Create private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count = var.az_count
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 21)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.name}-private-subnet-${format("%03d", count.index + 1)}"
    Environment = var.environment
  }
}