### Route Tables ###


# Private Route Table
resource "aws_default_route_table" "private" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  
  tags = {
    Name = "${var.name}-route-table-private"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_default_route_table.private.id
  count = var.az_count
  subnet_id = element(aws_subnet.private.*.id, count.index)
}


# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id 
  }

  tags = {
    Name = "${var.name}-route-table-public "
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  count = var.az_count
  subnet_id = element(aws_subnet.public.*.id, count.index)
}