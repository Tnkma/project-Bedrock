# Orders DB (MySQL RDS)
resource "aws_db_instance" "orders" {
  identifier           = "orders-db-instance"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 10
  db_name              = "order_db"
  username             = var.mysql_username
  password             = var.mysql_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
}


# Catalog DB (PostgreSQL RDS)
resource "aws_db_instance" "catalog" {
  identifier           = "catalog-db-instance"
  engine               = "postgres"
  engine_version       = "12.7"
  instance_class       = "db.t3.micro"
  allocated_storage    = 10
  db_name              = "catalog_db"
  username             = var.postgresql_username
  password             = var.postgresql_password
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
}



# Carts DB (DynamoDB Table)
resource "aws_dynamodb_table" "carts" {
  name         = "carts-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "cartId"

  attribute {
    name = "cartId"
    type = "S"
  }

  tags = {
    Service = "carts"
    Environment = "dev"
  }
}

resource "aws_iam_policy" "carts_dynamodb_policy" {
  name = "carts-dynamodb-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Resource = aws_dynamodb_table.carts.arn
      }
    ]
  })
}