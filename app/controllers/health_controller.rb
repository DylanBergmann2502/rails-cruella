# app/controllers/health_controller.rb
class HealthController < ActionController::API
  # Individual health check endpoints
  # GET /health/database
  def database
    render_check(:database, database_healthy?)
  end

  # GET /health/redis
  def redis
    render_check(:redis, redis_healthy?)
  end

  # GET /health/sidekiq
  def sidekiq
    render_check(:sidekiq, sidekiq_healthy?)
  end

  # GET /health/s3
  def s3
    render_check(:s3, s3_healthy?)
  end

  # Combined health check endpoint
  # GET /health or GET /health/all
  def all
    checks = {
      database: database_healthy?,
      redis: redis_healthy?,
      sidekiq: sidekiq_healthy?,
      s3: s3_healthy?
    }

    all_healthy = checks.values.all? { |check| check[:healthy] }
    status = all_healthy ? :ok : :service_unavailable

    render json: {
      status: all_healthy ? "healthy" : "unhealthy",
      checks: checks
    }, status: status
  end

  private

  def render_check(name, result)
    status = result[:healthy] ? :ok : :service_unavailable
    render json: {
      status: result[:healthy] ? "healthy" : "unhealthy",
      check: name,
      **result
    }, status: status
  end

  def database_healthy?
    ActiveRecord::Base.connection.execute("SELECT 1")
    {healthy: true}
  rescue => e
    {healthy: false, error: e.message}
  end

  def redis_healthy?
    redis = Redis.new(url: ENV.fetch("REDIS_URL", "redis://redis:6379/0"))
    redis.ping
    {healthy: true}
  rescue => e
    {healthy: false, error: e.message}
  ensure
    redis&.close
  end

  def sidekiq_healthy?
    processes = Sidekiq::ProcessSet.new
    process_count = processes.size

    if process_count > 0
      {healthy: true, processes: process_count}
    else
      {healthy: false, error: "No Sidekiq processes running"}
    end
  rescue => e
    {healthy: false, error: e.message}
  end

  def s3_healthy?
    return {healthy: true, skipped: true, reason: "S3 storage not enabled"} unless s3_enabled?

    client = Aws::S3::Client.new(
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: ENV.fetch("AWS_REGION", "us-east-1"),
      endpoint: ENV["AWS_ENDPOINT_URL"],
      force_path_style: ENV.fetch("AWS_FORCE_PATH_STYLE", "true") == "true"
    )

    bucket_name = ENV.fetch("AWS_BUCKET_NAME", "local-rails-cruella")

    # Test list objects (read permission)
    client.list_objects_v2(bucket: bucket_name, max_keys: 1)

    # Test put object (write permission)
    test_key = "health_check_#{Time.current.to_i}"
    client.put_object(bucket: bucket_name, key: test_key, body: "health check test")

    # Test delete object (delete permission)
    client.delete_object(bucket: bucket_name, key: test_key)

    {healthy: true}
  rescue => e
    {healthy: false, error: e.message}
  end

  def s3_enabled?
    Rails.env.production? || ENV["USE_S3_STORAGE"] == "true"
  end
end
