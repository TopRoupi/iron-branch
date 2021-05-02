# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require "minitest/autorun"
require "minitest/reporters"
require "shoulda/context"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  include FactoryBot::Syntax::Methods
end

# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new # spec-like progress
