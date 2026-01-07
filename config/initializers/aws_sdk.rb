# config/initializers/aws_sdk.rb

# Require AWS SDK S3 for S3 storage and health checks
begin
  require "aws-sdk-s3"
rescue LoadError
  # AWS SDK not available, S3 features will be disabled
end
