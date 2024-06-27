# Creating IAM Role & IAM Policy then attaching it to Role - for EKS

resource "aws_iam_role" "tacbot_managedcluster_role" {
  name = "${var.name}-eks-role"
  tags = local.tag_iam
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
    Version = "2012-10-17"
  })
}
resource "aws_iam_policy" "eks" {
  name        = "${var.name}-eks-restricted-policy"
  description = "Example IAM policy that uses multiple aws:PrincipalTag conditions"
  tags = local.tag_policy
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["ec2:DescribeInstances",
      "ec2:DescribeSnapshots",
        "elasticloadbalancing:DescribeLoadBalancerPolicies",        #ElasticLB
        "elasticloadbalancing:DeleteLoadBalancerListeners",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:CreateLoadBalancerListeners",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:ModifyTargetGroup",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DetachLoadBalancerFromSubnets",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:CreateLoadBalancerPolicy",
        "elasticloadbalancing:DeleteTargetGroup",
        "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
        "elasticloadbalancing:ConfigureHealthCheck",
        "elasticloadbalancing:ModifyTargetGroupAttributes",
        "elasticloadbalancing:AttachLoadBalancerToSubnets",
        "elasticloadbalancing:DeleteListener",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:CreateListener",
        "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:AddTags",
        "route53:AssociateVPCWithHostedZone",                       #Route53
        "ec2:DescribeVolumes",                                      #EC2
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeDhcpOptions",
        "ec2:DetachVolume",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSubnets",
        "ec2:DeleteRoute",
        "ec2:DescribeRouteTables",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:DescribeLaunchTemplateVersions",
        "ec2:CreateLaunchTemplateVersion",
        "ec2:CreateLaunchTemplate",
        "ec2:DescribeLaunchTemplates",
        "ec2:CreateTags",
        "ec2:DetachNetworkInterface",
        "ec2:ModifyVolume",
        "ec2:DeleteTags",
        "ec2:DescribeTags",
        "ec2:DeleteSecurityGroup",
        "ec2:CreateNetworkInterface",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeSecurityGroups",
        "ec2:CreateRoute",
        "ec2:DeleteVolume",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:DescribeInstanceTypes",
        "ec2:CreateSecurityGroup",
        "ec2:DescribeVolumesModifications",
        "ec2:DescribeInstanceAttribute",
        "ec2:DescribeAddresses",
        "ec2:AttachNetworkInterface",
        "ec2:ModifyNetworkInterfaceAttribute",
        "ec2:AttachVolume",
        "ec2:CreateVolume",
        "ec2:UnassignPrivateIpAddresses",
        "ec2:ModifyInstanceAttribute",
        "ec2:CreateSnapshot",
        "ec2:DeleteNetworkInterface",
        "ec2:AssignPrivateIpAddresses",
        "ec2:DescribeVpcs",
        "ec2:CreateNetworkInterfacePermission",
        "eks:UpdateClusterVersion",                         #EKS
        "eks:CreateNodegroup",
        "eks:DescribeCluster",
        "logs:CreateLogGroup",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams",
        "logs:CreateLogStream",
        "iam:ListAttachedRolePolicies",
        "ecr:BatchCheckLayerAvailability",                  #ECR
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:GetLifecyclePolicy",
        "ecr:GetRepositoryPolicy",  
        "ecr:DescribeImageScanFindings",
        "ecr:DescribeRepositories",
        "ecr:DescribeImages",
        "ecr:ListTagsForResource",
        "ecr:ListImages",        
        "ecr:GetLifecyclePolicyPreview",
        "ecr:GetAuthorizationToken",
        "autoscaling:DescribeAutoScalingGroups",        #ASG
        "autoscaling:UpdateAutoScalingGroup",
        "kms:DescribeKey",                              #KMS
        "iam:PassRole",
        "ses:SendEmail",                                #SES
        "ses:SendRawEmail",
        "lambda:InvokeFunction",                        #Lambda
        "lambda:CreateFunction",
        "lambda:DeleteFunction",
        "lambda:GetFunction",
        "lambda:ListFunctions"        
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_policy_attachement" {
  policy_arn = aws_iam_policy.eks.arn
  role       = aws_iam_role.tacbot_managedcluster_role.name

}
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.tacbot_managedcluster_role.name

}
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.tacbot_managedcluster_role.name

}
resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.tacbot_managedcluster_role.name

}

# tagging and naming resources
locals {
  tag_eks = {
    Name           = "${var.name}-eks"
    Project        = var.project
    Environment    = var.environment
  }
  tag_policy = {
    Name           = "${var.name}-eks-restricted-policy"
    Project        = var.project
    Environment    = var.environment
  }
  tag_iam = {
    Name           = "${var.name}-eks-role"
    Project        = var.project
    Environment    = var.environment
  }
  tag_rds = {
    Name           = "${var.name}-db"
    Project        = var.project
    Environment    = var.environment
  }
  tag_sg_eks = {
    Name           = "${var.name}-eks-sg"
    Project        = var.project
    Environment    = var.environment
  }
  tag_node_group = {
    Name           = "${var.name}-eks-node-group"
    Project        = var.project
    Environment    = var.environment
  }
  tag_subnet_group = {
    Name           = "${var.name}awsdbsubnetgroup"
    Project        = var.project
    Environment    = var.environment
  }
  tag_sg-rds = {
    Name           = "${var.name}-db-sg"
    Project        = var.project
    Environment    = var.environment
  }
  tag_parameter_group = {
    Name           = "${var.name}-db-pg"
    Project        = var.project
    Environment    = var.environment
  }
  tag_node = {
    Name           = "${var.name}-eks-node"
    Project        = var.project
    Environment    = var.environment
  }
  tag_template = {
    Name           = "${var.name}-eks-template"
    Project        = var.project
    Environment    = var.environment
  }
  tag_addon = {
    Name           = "${var.name}-eks-addon"
    Project        = var.project
    Environment    = var.environment
  }
   tag_sm = {
    Name           = "${var.name}-db-sm"
    Project        = var.project
    Environment    = var.environment
  }
}

#creating security group

resource "aws_security_group" "tacbot_eks_securitygroup" {
  name   = "${var.name}-eks-sg"
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.subnet_cidr_rds).*.cidr_block

  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.subnet_cidr_eks).*.cidr_block

  }
  ingress {
    from_port   = 9080
    to_port     = 9080
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.subnet_cidr_eks).*.cidr_block

  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.subnet_cidr_eks).*.cidr_block

  }
  ingress {
    from_port   = 4444
    to_port     = 4444
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.subnet_cidr_eks).*.cidr_block

  }
  ingress {
    from_port   = 9651
    to_port     = 9651
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.subnet_cidr_eks).*.cidr_block

  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.tacbot_RDS_securitygroup.id]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = local.tag_sg_eks
}

#creating cluster 


resource "aws_eks_cluster" "tacbot_eks_cluster" {
  name     = "${var.name}-eks"
  role_arn = aws_iam_role.tacbot_managedcluster_role.arn
  version  = var.eks_version

  vpc_config {
    subnet_ids = [aws_subnet.tacbotinc-dev-privatesubnet1a.id, 
                aws_subnet.tacbotinc-dev-privatesubnet1b.id ]
    security_group_ids      = ["${aws_security_group.tacbot_eks_securitygroup.id}"]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  tags = local.tag_eks

# launch template for EKS

}
resource "aws_launch_template" "tacbot_template" {
  name = "${var.name}-eks-template"

  network_interfaces {
    associate_public_ip_address = false
    security_groups = ["${aws_security_group.tacbot_eks_securitygroup.id}"]
    # Other network interface settings...
  }

  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size = var.volume_size
      volume_type = var.volume_type
    }

  }
  tag_specifications {
    resource_type = "instance"

    tags = local.tag_node
  }
  tags = local.tag_template
}

# add-on plugin

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name      = aws_eks_cluster.tacbot_eks_cluster.name
  addon_name        = "aws-ebs-csi-driver"
  addon_version     = "v1.25.0-eksbuild.1"  
     depends_on = [ aws_eks_node_group.tacbot_eks_nodegroup ]
  tags = local.tag_addon
}
#trying something before node group

locals {
  subnets = {
    private1a = {
      id   = aws_subnet.tacbotinc-dev-privatesubnet1a.id
      cidr = aws_subnet.tacbotinc-dev-privatesubnet1a.cidr_block
    }
    private1b = {
      id   = aws_subnet.tacbotinc-dev-privatesubnet1b.id
      cidr = aws_subnet.tacbotinc-dev-privatesubnet1b.cidr_block
    }
    private1c = {
      id   = aws_subnet.tacbotinc-dev-privatesubnet1c.id
      cidr = aws_subnet.tacbotinc-dev-privatesubnet1c.cidr_block
    }
    public1a = {
      id   = aws_subnet.tacbotinc-dev-publicsubnet1a.id
      cidr = aws_subnet.tacbotinc-dev-publicsubnet1a.cidr_block
    }
    public1b = {
      id   = aws_subnet.tacbotinc-dev-publicsubnet1b.id
      cidr = aws_subnet.tacbotinc-dev-publicsubnet1b.cidr_block
    }
    public1c = {
      id   = aws_subnet.tacbotinc-dev-publicsubnet1c.id
      cidr = aws_subnet.tacbotinc-dev-publicsubnet1c.cidr_block
    }
  }
}


# adding node group

resource "aws_eks_node_group" "tacbot_eks_nodegroup" {
  cluster_name    = aws_eks_cluster.tacbot_eks_cluster.name
  node_group_name = "${var.name}-eks-node-group"
  node_role_arn   = aws_iam_role.tacbot_managedcluster_role.arn
  subnet_ids    = [aws_subnet.tacbotinc-dev-privatesubnet1a.id, 
                aws_subnet.tacbotinc-dev-privatesubnet1b.id ]
  capacity_type = var.ng_capacity_type
  labels        = var.test_labels

  scaling_config {
    desired_size = var.ng_desired_size
    max_size     = var.ng_max_size
    min_size     = var.ng_min_size

  }

  instance_types = var.ng_instance_types
  tags           = local.tag_node_group
  launch_template {
    id      = aws_launch_template.tacbot_template.id
    version = "$Latest" 
     
  }

}


data "aws_subnet" "subnet_cidr_eks" {
#   for_each = toset([aws_subnet.tacbotinc-dev-privatesubnet1a, aws_subnet.tacbotinc-dev-privatesubnet1b, aws_subnet.tacbotinc-dev-privatesubnet1c, aws_subnet.tacbotinc-dev-publicsubnet1a, aws_subnet.tacbotinc-dev-privatesubnet1b, aws_subnet.tacbotinc-dev-publicsubnet1c])
  for_each = local.subnets
  id       = each.value.id
#   depends_on = [aws_subnet.tacbotinc-dev-privatesubnet1a, aws_subnet.tacbotinc-dev-privatesubnet1b, aws_subnet.tacbotinc-dev-privatesubnet1c, aws_subnet.tacbotinc-dev-publicsubnet1a, aws_subnet.tacbotinc-dev-privatesubnet1b, aws_subnet.tacbotinc-dev-publicsubnet1c]
}

data "aws_subnet" "subnet_cidr_rds" {
#   for_each = toset([aws_subnet.tacbotinc-dev-privatesubnet1a, aws_subnet.tacbotinc-dev-privatesubnet1b, aws_subnet.tacbotinc-dev-privatesubnet1c, aws_subnet.tacbotinc-dev-publicsubnet1a, aws_subnet.tacbotinc-dev-privatesubnet1b, aws_subnet.tacbotinc-dev-publicsubnet1c])
  for_each = local.subnets
  id       = each.value.id
}


# managing secrets and passwords

resource "random_password" "tacbot_rds_password" {
  length           = 16
  special          = true
  override_special = "defekbnfudddfreehb134424"

}


resource "aws_secretsmanager_secret" "tacbot_rds_secretmaster" {
  name = "${var.secret_name}-dbsecret"  
  tags = local.tag_sm
}

resource "aws_secretsmanager_secret_version" "tacbot_rds_version" {
  secret_id     = aws_secretsmanager_secret.tacbot_rds_secretmaster.id
  secret_string = <<EOF
   {
    "username": "${var.rds_postgres_username}",
    "password": "${random_password.tacbot_rds_password.result}"
   }
EOF

}

# creating security group

resource "aws_security_group" "tacbot_RDS_securitygroup" {
  name   = "${var.name}-db-sg"
  vpc_id = aws_vpc.tacbotinc-dev-vpc.id


  ingress {
    from_port   = var.RDS_from_port
    to_port     = var.RDS_to_port
    protocol    = var.RDS_protocol
    cidr_blocks = values(data.aws_subnet.subnet_cidr_eks).*.cidr_block

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = local.tag_sg-rds
}
#creating subnet group
resource "aws_db_subnet_group" "tacbotinc_subnet_group" {
  subnet_ids = [aws_subnet.tacbotinc-dev-privatesubnet1a.id, 
                aws_subnet.tacbotinc-dev-privatesubnet1b.id ] 
                # aws_subnet.tacbotinc-dev-privatesubnet1c.id, 
                # aws_subnet.tacbotinc-dev-publicsubnet1a.id, 
                # aws_subnet.tacbotinc-dev-publicsubnet1b.id, 
                # aws_subnet.tacbotinc-dev-publicsubnet1c.id]
  tags = {
    Name = "${var.db_subnet_group_name}"
  }
}

# this is creating RDS
resource "aws_db_instance" "tacbot_rds_postgres_dbinstance" {
  identifier                      = "${var.name}rds"
  instance_class                  = var.rds_postgres_instance_class
  allocated_storage               = var.rds_postgres_allocated_storage
  engine                          = var.rds_engine
  db_name                         = "${var.name}_rds"
  engine_version                  = var.rds_postgres_engine_version
  username                        = var.rds_postgres_username
  password                        = random_password.tacbot_rds_password.result
  db_subnet_group_name            = aws_db_subnet_group.tacbotinc_subnet_group.name
  parameter_group_name            = aws_db_parameter_group.tacbot_rds_dbparameter_group.name
  skip_final_snapshot             = true
  storage_encrypted               = true
  enabled_cloudwatch_logs_exports = ["postgresql"]
  backup_retention_period         = var.rds_backup_retention_period
  auto_minor_version_upgrade      = false
  vpc_security_group_ids          = ["${aws_security_group.tacbot_RDS_securitygroup.id}"]
  tags                            = local.tag_rds
  depends_on = [ aws_db_subnet_group.tacbotinc_subnet_group ]
}
resource "aws_db_parameter_group" "tacbot_rds_dbparameter_group" {
  name   = "${var.name}dbpg1"
  family = "postgres15"
  parameter {
    name  = "log_connections"
    value = "1"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = local.tag_parameter_group
}

