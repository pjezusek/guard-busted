# frozen_string_literal: true

require 'bundler/setup'
require 'simplecov'
require 'simplecov-cobertura'
require 'amazing_print'

SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch

  track_files '**/*.rb'

  add_filter %r{^/spec/}

  add_group 'Gem files', 'lib'

  if ENV['CI']
    formatter SimpleCov::Formatter::MultiFormatter.new(
      [
        SimpleCov::Formatter::HTMLFormatter,
        SimpleCov::Formatter::CoberturaFormatter
      ]
    )
  else
    formatter SimpleCov::Formatter::MultiFormatter.new(
      [
        SimpleCov::Formatter::SimpleFormatter,
        SimpleCov::Formatter::HTMLFormatter
      ]
    )
  end
end

require 'guard/busted'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Filter specs using focus keyword
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

RSpec::Expectations.configuration.on_potential_false_positives = :nothing
