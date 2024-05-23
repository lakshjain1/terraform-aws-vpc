resource "aws_vpc" "main" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support = var.enable_dns_support

    tags = merge (
        var.common_tags,
        {
            Name = var.project_name
        },
        var.vpc_tags
    )  
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = merge(
        var.common_tags,
        {
            Name = var.project_name
        },
        var.igw_tags
    )
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = local.azs[count.index]
    tags = merge(
        var.common_tags,
        {
            Name = "${var.project_name}-public-${local.azs[count.index]}"
        }
    )

}

resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = local.azs[count.index]
    tags = merge(
        var.common_tags,
        {
            Name = "${var.project_name}-private-${local.azs[count.index]}"
        }
    )

}


resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = merge(
        var.common_tags,
        {
            Name = "${var.project_name}-public"
        }
    )
}