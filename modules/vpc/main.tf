
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-igw"
  }
}


resource "aws_subnet" "pub_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.pub_sub_1_cidr
  availability_zone = var.azs[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-pub-sub-1"
  }
}

resource "aws_subnet" "pub_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.pub_sub_2_cidr
  availability_zone = var.azs[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-pub-sub-2"
  }
}


resource "aws_subnet" "priv_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.priv_sub_1_cidr
  availability_zone = var.azs[0]
  tags = {
    Name = "${var.env}-priv-sub-1"
  }
}

resource "aws_subnet" "priv_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.priv_sub_2_cidr
  availability_zone = var.azs[1]
  tags = {
    Name = "${var.env}-priv-sub-2"
  }
}


resource "aws_eip" "nat" {
  domain = "vpc"
  tags = { 
    Name = "${var.env}-nat-eip"
     }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.pub_1.id 
  depends_on = [aws_internet_gateway.gw]
  tags = {
     Name = "${var.env}-nat-gw"
      }
}


resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = { Name = "${var.env}-pub-rt" }
}


resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "${var.env}-priv-rt" }
}


resource "aws_route_table_association" "pub_1_assoc" {
  subnet_id = aws_subnet.pub_1.id
  route_table_id = aws_route_table.pub_rt.id
}
resource "aws_route_table_association" "pub_2_assoc" {
  subnet_id = aws_subnet.pub_2.id
  route_table_id = aws_route_table.pub_rt.id
}


resource "aws_route_table_association" "priv_1_assoc" {
  subnet_id = aws_subnet.priv_1.id
  route_table_id = aws_route_table.priv_rt.id
}
resource "aws_route_table_association" "priv_2_assoc" {
  subnet_id = aws_subnet.priv_2.id
  route_table_id = aws_route_table.priv_rt.id
}



