# frozen_string_literal: true

require 'webmock/rspec'
require "autodesk/forge"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Disable connection to reach the internet
  config.before :suite do
    WebMock.disable_net_connect!
  end

  # Remove all stubs created by WebMock
  config.before :each do
    WebMock.reset!
  end
end
