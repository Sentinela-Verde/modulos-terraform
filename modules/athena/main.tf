resource "aws_athena_workgroup" "this" {
  name = var.workgroup_name

  configuration {
    enforce_workgroup_configuration = var.enforce_workgroup_configuration
    bytes_scanned_cutoff_per_query  = var.bytes_scanned_cutoff_per_query

    result_configuration {
      output_location = var.output_location
    }
  }

  tags = var.tags
}
