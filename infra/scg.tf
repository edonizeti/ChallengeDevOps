### Security Groups ###

# Aplication Load Balance
resource "aws_security_group" "alb" {
  name = "${var.name}-alb-scg"
  vpc_id = aws_vpc.main.id

  ingress {
    protocol = "tcp"
    from_port = var.app_port
    to_port = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-alb-scg"
    Environment = var.environment
  }
}


