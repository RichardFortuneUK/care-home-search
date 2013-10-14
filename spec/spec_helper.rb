require 'simplecov'
require 'coveralls'

SimpleCov.start do
  add_filter '/vendor'
  add_filter '/spec'
  add_filter '/features'
  coverage_dir 'reports/coverage'
end

require 'id'
require 'models/search'

RSpec.configure do |config|
  config.mock_with :mocha
  config.order = "random"
end