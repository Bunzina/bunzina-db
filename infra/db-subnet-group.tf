resource "aws_db_subnet_group" "this" {
  name       = local.resource_name
  subnet_ids = var.subnet_ids

  tags = merge(local.common_tags, {
    Name = "${local.resource_name}-subnet-group"
  })
}
