# Security group for DBs
resource "aws_security_group" "db_sg" {
  name   = "db-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

# Allow EKS worker nodes to access MySQL (3306)
resource "aws_security_group_rule" "allow_eks_to_rds_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.eks_node_sg_id
  security_group_id        = aws_security_group.db_sg.id
}

# Allow EKS worker nodes to access Postgres (5432)
resource "aws_security_group_rule" "allow_eks_to_rds_postgres" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.eks_node_sg_id
  security_group_id        = aws_security_group.db_sg.id
}

# Subnet group for DBs
resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "main-db-subnet-group"
  }
}
