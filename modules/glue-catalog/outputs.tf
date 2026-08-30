output "database_name" {
  description = "Nome do Glue Data Catalog Database"
  value       = aws_glue_catalog_database.this.name
}

output "database_arn" {
  description = "ARN do Glue Data Catalog Database"
  value       = aws_glue_catalog_database.this.arn
}

output "crawler_arn" {
  description = "ARN do crawler criado (vazio se create_crawler = false)"
  value       = try(aws_glue_crawler.this[0].arn, null)
}
