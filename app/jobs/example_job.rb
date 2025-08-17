# app/jobs/example_job.rb
class ExampleJob < ApplicationJob
  queue_as :default

  def perform(message = "Hello from Sidekiq!")
    Rails.logger.info "ExampleJob executing with message: #{message}"

    # Simulate some work
    sleep(2)

    Rails.logger.info "ExampleJob completed successfully"
  end
end
