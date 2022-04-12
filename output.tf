output "alb" {
  value = aws_alb.myapp-alb.dns_name
}

output "cloudfront" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}