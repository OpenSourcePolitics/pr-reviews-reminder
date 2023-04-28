# frozen_string_literal: true

Dir.glob("#{File.dirname(__FILE__)}/support/**/*.rb").each { |f| require f }

RSpec.configure do |config|
  config.include EnvironmentSupport
end
