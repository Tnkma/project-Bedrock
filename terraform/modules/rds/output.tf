output "orders_db_endpoint" {
  value = aws_db_instance.orders.endpoint
}

output "catalog_db_endpoint" {
  value = aws_db_instance.catalog.endpoint
}

output "carts_table_name" {
  value = aws_dynamodb_table.carts.name
}

output "carts_dynamodb_policy_arn" {
  value = aws_iam_policy.carts_dynamodb_policy.arn
}
