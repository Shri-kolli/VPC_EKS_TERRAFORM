cidr = "10.100.0.0/16"
vpc_name = "tacbotinc-dev-vpc"
region = "us-east-1"

az1 = "us-east-1a"
az2 = "us-east-1b"
az3 = "us-east-1c"

public_subnet_1a_cidr = "10.100.1.0/24"
public_subnet_1b_cidr = "10.100.2.0/24"
public_subnet_1c_cidr = "10.100.3.0/24"

public_subnet_1a_name = "tacbotinc-dev-publicsubnet1a"
public_subnet_1b_name = "tacbotinc-dev-publicsubnet1b"
public_subnet_1c_name = "tacbotinc-dev-publicsubnet1c"

igw_name = "tacbotinc-dev-igw"
rt_name = "tacbotinc-dev-public-RT"

private_subnet_1a_cidr = "10.100.4.0/24"
private_subnet_1b_cidr = "10.100.5.0/24"
private_subnet_1c_cidr = "10.100.6.0/24"

private_subnet_1a_name = "tacbotinc-dev-privatesubnet1a"
private_subnet_1b_name = "tacbotinc-dev-privatesubnet1b"
private_subnet_1c_name = "tacbotinc-dev-privatesubnet1c"

nat_gw_name = "tacbotinc-dev-nat-gateway"
private_rt_name = "tacbotinc-dev-private-RT"

env = "dev"

/* tfvar for EKS and RDS */

ng_disk_size                   = 20
ng_capacity_type               = "ON_DEMAND"
ng_desired_size                = 2
ng_max_size                    = 2
ng_min_size                    = 2
eks_version                    = "1.29"
ng_instance_types              = ["t3.medium"]

/* RDS attributes*/
rds_postgres_instance_class    = "db.t3.micro"  #
rds_postgres_allocated_storage = 20
rds_postgres_engine_version    = "15"
rds_postgres_username          = "root122"
rds_backup_retention_period    = "7"
rds_engine                     = "postgres"
name                           = "tacbotinc"

/* these are tags to give access through attribute based access control */
project                        = "tacbotinc"
environment                    = "Dev"

/* db related attributes */
secret_name                    = "tacbotsecret"
RDS_from_port                  = 5432
RDS_to_port                    = 5432
RDS_protocol                   = "tcp"
device_name                    = "/dev/xvda"
volume_size                    = 20
volume_type                    = "gp2"
db_subnet_group_name           = "tacbotinc-subnet-group"
