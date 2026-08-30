resource "aws_glue_catalog_database" "this" {
  name        = var.database_name
  description = var.database_description
}

resource "aws_glue_crawler" "this" {
  count = var.create_crawler ? 1 : 0

  name          = var.crawler_name
  role          = var.crawler_role_arn
  database_name = aws_glue_catalog_database.this.name
  schedule      = var.crawler_schedule

  s3_target {
    path = var.crawler_s3_target_path
  }

  tags = var.tags
}
