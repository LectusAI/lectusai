output "news_scraper_function_name" {
  description = "Name of the news scraper Lambda function"
  value       = aws_lambda_function.news_scraper.function_name
}

output "news_scraper_function_arn" {
  description = "ARN of the news scraper Lambda function"
  value       = aws_lambda_function.news_scraper.arn
}

output "content_processor_function_name" {
  description = "Name of the content processor Lambda function"
  value       = aws_lambda_function.content_processor.function_name
}

output "content_processor_function_arn" {
  description = "ARN of the content processor Lambda function"
  value       = aws_lambda_function.content_processor.arn
}

output "trend_analyzer_function_name" {
  description = "Name of the trend analyzer Lambda function"
  value       = aws_lambda_function.trend_analyzer.function_name
}

output "trend_analyzer_function_arn" {
  description = "ARN of the trend analyzer Lambda function"
  value       = aws_lambda_function.trend_analyzer.arn
}

output "lambda_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_role.arn
}

output "lambda_security_group_id" {
  description = "Security group ID for Lambda functions"
  value       = aws_security_group.lambda.id
}