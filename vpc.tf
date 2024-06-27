# Creating VPC
resource "aws_vpc" "tacbotinc-dev-vpc" {         
    cidr_block = var.cidr
    tags = {
        Name = "${var.vpc_name}"
    }
    
}

# Creating Public Subnets
resource "aws_subnet" "tacbotinc-dev-publicsubnet1a" {
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id
  cidr_block = "${var.public_subnet_1a_cidr}"
  availability_zone = var.az1         
  tags = {
    Name = "${var.public_subnet_1a_name}"
  }
}

resource "aws_subnet" "tacbotinc-dev-publicsubnet1b" {
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id
  cidr_block = "${var.public_subnet_1b_cidr}"
  availability_zone = var.az2         
  tags = {
    Name = "${var.public_subnet_1b_name}"
  }
}

resource "aws_subnet" "tacbotinc-dev-publicsubnet1c" {
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id
  cidr_block = "${var.public_subnet_1c_cidr}"
  availability_zone = var.az3         
  tags = {
    Name = "${var.public_subnet_1c_name}"
  }
}

# Creating Internet Gateway for public route table
resource "aws_internet_gateway" "tacbotinc-dev-igw" {
    vpc_id = aws_vpc.tacbotinc-dev-vpc.id
    tags = {
      Name = "${var.igw_name}"
    }
}

# Updating Route Table and Subnet Association
resource "aws_route_table" "tacbotinc-dev-public-RT" {
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id
  tags = {
    Name = "${var.rt_name}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tacbotinc-dev-igw.id
  }
}

resource "aws_route_table_association" "public-RTa1" {
    route_table_id = aws_route_table.tacbotinc-dev-public-RT.id
    subnet_id =   aws_subnet.tacbotinc-dev-publicsubnet1a.id
}

resource "aws_route_table_association" "public-RTa2" {
    route_table_id = aws_route_table.tacbotinc-dev-public-RT.id
    subnet_id =   aws_subnet.tacbotinc-dev-publicsubnet1b.id
}

resource "aws_route_table_association" "public-RTa3" {
    route_table_id = aws_route_table.tacbotinc-dev-public-RT.id
    subnet_id =   aws_subnet.tacbotinc-dev-publicsubnet1c.id
}

# Creating Private Subnets 
resource "aws_subnet" "tacbotinc-dev-privatesubnet1a" {
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id
  cidr_block = "${var.private_subnet_1a_cidr}"
  availability_zone = var.az1         
  tags = {
    Name = "${var.private_subnet_1a_name}"
  }
}

resource "aws_subnet" "tacbotinc-dev-privatesubnet1b" {
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id
  cidr_block = "${var.private_subnet_1b_cidr}"
  availability_zone = var.az2         
  tags = {
    Name = "${var.private_subnet_1b_name}"
  }
}

resource "aws_subnet" "tacbotinc-dev-privatesubnet1c" {
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id
  cidr_block = "${var.private_subnet_1c_cidr}"
  availability_zone = var.az3         
  tags = {
    Name = "${var.private_subnet_1c_name}"
  }
}

# Creating elastic IP and assign to NAT Gateway 
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "tacbotinc-dev-nat-gateway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.tacbotinc-dev-publicsubnet1c.id
    depends_on = [ aws_eip.nat_eip ]        #ensures aws_eip is created first
    tags = {
      Name = "${var.nat_gw_name}"
    }
}

resource "aws_route_table" "tacbotinc-dev-private-RT" {
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id
  tags = {
    Name = "${var.private_rt_name}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tacbotinc-dev-nat-gateway.id
  }
}

resource "aws_route_table_association" "private-RTa1" {
  route_table_id = aws_route_table.tacbotinc-dev-private-RT.id
  subnet_id = aws_subnet.tacbotinc-dev-privatesubnet1a.id
}

resource "aws_route_table_association" "private-RTa2" {
  route_table_id = aws_route_table.tacbotinc-dev-private-RT.id
  subnet_id = aws_subnet.tacbotinc-dev-privatesubnet1b.id
}

resource "aws_route_table_association" "private-RTa3" {
  route_table_id = aws_route_table.tacbotinc-dev-private-RT.id
  subnet_id = aws_subnet.tacbotinc-dev-privatesubnet1c.id
}

