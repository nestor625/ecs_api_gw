resource "aws_resourcegroups_group" "main" {
  name = "${var.project_name}-${var.tag_env}"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "Proj",
      "Values": ["${var.tag_proj}"]
    },
    {
      "Key": "env",
      "Values": ["${var.tag_env}"]
    }
  ]
}
JSON
  }
}