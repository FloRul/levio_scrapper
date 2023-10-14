variable "s3_path" {
  default = "amazon-connect-753032b15c4c"
}

variable "packaged_lambda_path" {
  default = "../lambda/package.zip"
}

variable "lambda_handler" {
  default = "index.lambda_handler"
}

variable "packager_path" {
  default = "../lambda/packager.sh"
}

variable "function_name" {
  default = "simple_webpage_scraper"
}
variable "function_desc" {
  default = "A simple web page scraper"
}
variable "runtime" {
  default = "python3.11"
}
