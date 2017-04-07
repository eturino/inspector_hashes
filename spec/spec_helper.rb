require 'bundler/setup'
require 'pry'
require 'coveralls'
Coveralls.wear!

require 'inspector_hashes'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
