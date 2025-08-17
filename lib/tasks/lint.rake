# lib/tasks/lint.rake
namespace :lint do
  desc "Run StandardRB linter"
  task :standard do
    sh "bundle exec standardrb"
  end

  desc "Auto-fix StandardRB issues"
  task :fix do
    sh "bundle exec standardrb --fix"
  end

  desc "Run Brakeman security scanner"
  task :security do
    sh "bundle exec brakeman -c config/brakeman.yml"
  end

  desc "Run all linting tools (Standard + Brakeman)"
  task all: [:standard, :security] do
    puts "✅ All linting checks passed!"
  end
end

# Alias for convenience
desc "Run all linting tools"
task lint: "lint:all"
