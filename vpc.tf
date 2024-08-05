provider "aws" {
    region = "eu-central-1"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

resource "aws_vpc" "mektup-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "mektup_vpc_erdem"
  }
}


### PUBLIC SUBNET

resource "aws_subnet" "public-mektup-subnet" {
  vpc_id = aws_vpc.mektup-vpc.id
  cidr_block = var.public-subnet-cidr
  tags = {
    Name = "mektup_public_subnet"
  }
}

resource "aws_internet_gateway" "mektup-internet-gateway" {
  vpc_id = aws_vpc.mektup-vpc.id
  tags = {
    Name = "main_igw"
  }
}

resource "aws_route_table" "mektup-route-table-public" {
  vpc_id = aws_vpc.mektup-vpc.id
  route {
    cidr_block = var.mektup-route-table-public
    gateway_id = aws_internet_gateway.mektup-internet-gateway.id
  }
  tags = {
    Name = "mektup_route_table_public"
  }
}

resource "aws_route_table_association" "mektup-route-table-association-public-subnet" {
  subnet_id = aws_subnet.public-mektup-subnet.id
  route_table_id = aws_route_table.mektup-route-table-public.id
}


### PRIVATE SUBNET

resource "aws_subnet" "private-mektup-subnet" {
  vpc_id = aws_vpc.mektup-vpc.id
  cidr_block = var.private-subnet-cidr
  tags = {
    Name = "mektup_private_subnet"
  }
}

# Private subnet için Route Table (yönlendirme tablosu) oluşturur
resource "aws_route_table" "mektup_route_table_private" {
  vpc_id = aws_vpc.mektup-vpc.id

  # Private subnet için internet erişimi yok
  # İç trafiğe izin verir
  tags = {
    Name = "mektup_route_table_private"
  }
}

# Private subnet ile Route Table'ı ilişkilendirir
resource "aws_route_table_association" "mektup_route_table_association_private_subnet" {
  subnet_id      = aws_subnet.private-mektup-subnet.id
  route_table_id = aws_route_table.mektup_route_table_private.id
}
