# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv'
Dotenv.load

require 'simplecov'

SimpleCov.start do
  add_filter ENV.fetch('GEM_HOME', nil) if ENV.fetch('GEM_HOME', '').include?('bundle')
  add_filter 'spec/support'
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'translator-text'
require 'webmock/rspec'
require 'support/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  include TranslatorText::Rspec
end
