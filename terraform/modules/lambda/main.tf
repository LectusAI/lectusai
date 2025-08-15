# Lambda Module for AI News Aggregator

# Security Group for Lambda functions
resource "aws_security_group" "lambda" {
  name_prefix = "${var.name_prefix}-lambda-"
  vpc_id      = var.vpc_id
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-lambda-sg"
  })
}

# IAM Role for Lambda functions
resource "aws_iam_role" "lambda_role" {
  name = "${var.name_prefix}-lambda-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
  
  tags = var.tags
}

# IAM Policy for Lambda functions
resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.name_prefix}-lambda-policy"
  role = aws_iam_role.lambda_role.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "*"
      }
    ]
  })
}

# CloudWatch Log Groups for Lambda functions
resource "aws_cloudwatch_log_group" "news_scraper" {
  name              = "/aws/lambda/${var.name_prefix}-news-scraper"
  retention_in_days = 14
  
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "content_processor" {
  name              = "/aws/lambda/${var.name_prefix}-content-processor"
  retention_in_days = 14
  
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "trend_analyzer" {
  name              = "/aws/lambda/${var.name_prefix}-trend-analyzer"
  retention_in_days = 14
  
  tags = var.tags
}

# Placeholder Lambda functions (will be deployed via CI/CD)
resource "aws_lambda_function" "news_scraper" {
  filename         = "placeholder.zip"
  function_name    = "${var.name_prefix}-news-scraper"
  role            = aws_iam_role.lambda_role.arn
  handler         = "main.handler"
  runtime         = "python3.12"
  timeout         = 300
  memory_size     = 512
  
  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.lambda.id]
  }
  
  environment {
    variables = {
      ENVIRONMENT = "dev"
    }
  }
  
  depends_on = [
    aws_iam_role_policy.lambda_policy,
    aws_cloudwatch_log_group.news_scraper,
  ]
  
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-news-scraper"
  })
  
  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}

resource "aws_lambda_function" "content_processor" {
  filename         = "placeholder.zip"
  function_name    = "${var.name_prefix}-content-processor"
  role            = aws_iam_role.lambda_role.arn
  handler         = "main.handler"
  runtime         = "python3.12"
  timeout         = 300
  memory_size     = 1024
  
  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.lambda.id]
  }
  
  environment {
    variables = {
      ENVIRONMENT = "dev"
    }
  }
  
  depends_on = [
    aws_iam_role_policy.lambda_policy,
    aws_cloudwatch_log_group.content_processor,
  ]
  
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-content-processor"
  })
  
  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}

resource "aws_lambda_function" "trend_analyzer" {
  filename         = "placeholder.zip"
  function_name    = "${var.name_prefix}-trend-analyzer"
  role            = aws_iam_role.lambda_role.arn
  handler         = "main.handler"
  runtime         = "python3.12"
  timeout         = 900
  memory_size     = 2048
  
  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [aws_security_group.lambda.id]
  }
  
  environment {
    variables = {
      ENVIRONMENT = "dev"
    }
  }
  
  depends_on = [
    aws_iam_role_policy.lambda_policy,
    aws_cloudwatch_log_group.trend_analyzer,
  ]
  
  tags = merge(var.tags, {
    Name = "${var.name_prefix}-trend-analyzer"
  })
  
  lifecycle {
    ignore_changes = [filename, source_code_hash]
  }
}

# EventBridge rules for scheduling
resource "aws_cloudwatch_event_rule" "news_scraper_schedule" {
  name                = "${var.name_prefix}-news-scraper-schedule"
  description         = "Trigger news scraper every 2 hours"
  schedule_expression = "rate(2 hours)"
  
  tags = var.tags
}

resource "aws_cloudwatch_event_target" "news_scraper_target" {
  rule      = aws_cloudwatch_event_rule.news_scraper_schedule.name
  target_id = "NewsScraperTarget"
  arn       = aws_lambda_function.news_scraper.arn
}

resource "aws_lambda_permission" "allow_eventbridge_news_scraper" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.news_scraper.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.news_scraper_schedule.arn
}

# Create placeholder zip file
data "archive_file" "placeholder" {
  type        = "zip"
  output_path = "placeholder.zip"
  source {
    content  = "def handler(event, context): return {'statusCode': 200}"
    filename = "main.py"
  }
}