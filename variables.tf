variable "cidr" {
  description = "Holds the CIDR range of VPC"
}

# variable "aws_access_key" {
#   description = "aws user's access key"
# }

# variable "aws_secret_key" {
#   description = "aws user's secret key"
# }

variable "vpc_name" {
    type = string
    description = "vpc name"
}

variable "az1" {
    type = string
    description = "availability zone 1"  
}

variable "az2" {
    type = string
    description = "availability zone 2"  
}

variable "az3" {
    type = string
    description = "availability zone 3"  
}

variable "public_subnet_1a_cidr" {
  type        = string
  description = "subnet 1a CIDR block"
}

variable "public_subnet_1b_cidr" {
  type        = string
  description = "subnet 1b CIDR block"
}

variable "public_subnet_1c_cidr" {
  type        = string
  description = "subnet 1c CIDR block"
}

variable "public_subnet_1a_name" {
  type        = string
  description = "subnet 1a CIDR name"
}

variable "public_subnet_1b_name" {
  type        = string
  description = "subnet 1b CIDR name"
}

variable "public_subnet_1c_name" {
  type        = string
  description = "subnet 1c CIDR name"
}

variable "igw_name" {
  description = "IGW name"
}

variable "rt_name" {    
    description = "Route table name"
}

variable "private_subnet_1a_cidr" {
  type        = string
  description = "subnet 1a CIDR block"
}

variable "private_subnet_1b_cidr" {
  type        = string
  description = "subnet 1b CIDR block"
}

variable "private_subnet_1c_cidr" {
  type        = string
  description = "subnet 1c CIDR block"
}

variable "private_subnet_1a_name" {
  type        = string
  description = "subnet 1a CIDR name"
}

variable "private_subnet_1b_name" {
  type        = string
  description = "subnet 1b CIDR name"
}

variable "private_subnet_1c_name" {
  type        = string
  description = "subnet 1c CIDR name"
}

variable "nat_gw_name" {
    type = string
    description = "Nat Gateway Name"
}

variable "private_rt_name" {
    type = string
    description = "Private Route table Name" 
}

variable "env" {
    type = string
    description = "stage"
}

/* variables for EKS and RDS */

variable "ng_disk_size" {
  type        = number
  description = "Disk size for eks"
}
variable "ng_capacity_type" {
  type        = string
  description = "Capacity type for nodegroup"
}
variable "test_labels" {
  type        = map(string)
  description = "Lables for the node group"
  default     = {}
}
variable "ng_instance_types" {
  type        = list(string)
  description = "Enter the list of the instance type"

}
variable "ng_desired_size" {
  type        = number
  description = "Values for node desired size"
}
variable "ng_min_size" {
  type        = string
  description = "Values for node mix size"

}
variable "ng_max_size" {
  type        = string
  description = "Values for node max size"
}

variable "eks_version" {
  description = "Disable api termination"
  type        = number
}

variable "rds_postgres_instance_class" {
  description = "Instance class"
  type        = string
}

variable "rds_postgres_allocated_storage" {
  description = "Storage allocation"
  type        = number
}

variable "secret_name" {
  description = "Secret name"
  type        = string
}

variable "rds_postgres_engine_version" {
  description = "Version of postgres instance"
  type        = string
}

variable "rds_postgres_username" {
  description = "Postgres username"
  type        = string
}

variable "rds_backup_retention_period" {
  description = "Backup retention period"
  type        = number
}
variable "rds_engine" {
  description = "RDS engine"
  type        = string
}



variable "name" {
  description = "Tag valur for name"
  type        = string
}
variable "project" {
  description = "Tag valur for project"
  type        = string
}

variable "environment" {
  description = "Tag valur for environment"
  type        = string
}



variable "region" {
  description = "Region"
  type        = string
}

variable "db_subnet_group_name" {
  description = "DB subnet group name name for rds"
  type        = string
}

variable "RDS_from_port" {
  description = "Port to be allow in rds sg from port"
  type        = number
}
variable "RDS_to_port" {
  description = "Prot to be allow in rds sg end port"
  type        = number
}
variable "RDS_protocol" {
  description = "Protocol for port in rds sg"
  type        = string
}

variable "device_name" {
  description = "KMS key for encreption"
  type        = string
}
variable "volume_size" {
  description = "KMS key for encreption"
  type        = number
}
variable "volume_type" {
  description = "KMS key for encreption"
  type        = string
}