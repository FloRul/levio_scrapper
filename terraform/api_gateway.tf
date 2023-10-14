resource "aws_api_gateway_rest_api" "simple_scraper_api" {
  name = "SimpleScraperApi"
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.simple_scraper_api.id
  parent_id   = aws_api_gateway_rest_api.simple_scraper_api.root_resource_id
  path_part   = "scrape" # Change as needed
}

resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.simple_scraper_api.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.simple_scraper_api.id
  resource_id             = aws_api_gateway_resource.root.id
  http_method             = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "simple_scraper_api_deployment" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.simple_scraper_api.id
  stage_name  = "dev" # Change to your desired stage name
}

output "api_gateway_invoke_url" {
  value = aws_api_gateway_deployment.simple_scraper_api_deployment.invoke_url
}
