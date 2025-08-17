# config/initializers/aws_sdk.rb

# Require AWS SDK S3 for health checks gem detection
# The health_check gem checks for AWS SDK availability at initialization
begin
  require 'aws-sdk-s3'
rescue LoadError
  # AWS SDK not available, S3 health checks will be disabled
end