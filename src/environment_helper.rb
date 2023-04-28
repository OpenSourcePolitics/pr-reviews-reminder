# frozen_string_literal: true

# This is a helper class for the environment variables.
class EnvironmentHelper
  def self.working_configuration?
    new.missing_configuration.empty?
  end

  def self.missing_configuration
    new.missing_configuration
  end

  def self.for(key)
    new.configuration[key]
  end

  def initialize
    @names_map = ENV.fetch('NAMES_MAP', nil)
    @rocket_channel = ENV.fetch('ROCKET_CHANNEL', nil)
    @rocket_url = ENV.fetch('ROCKET_URL', nil)
    @rocket_username = ENV.fetch('ROCKET_USERNAME', nil)
    @rocket_password = ENV.fetch('ROCKET_PASSWORD', nil)
    @github_access_token = ENV.fetch('GITHUB_ACCESS_TOKEN', nil)
    @organization = ENV.fetch('ORGANIZATION', nil)
    @api_token = ENV.fetch('API_TOKEN', nil)
  end

  def configuration
    @configuration ||= instance_variables.each_with_object({}) do |var, hash|
      hash[var.to_s.delete('@').to_sym] = instance_variable_get(var)
    end
  end

  def missing_configuration
    configuration.select { |_, value| value.nil? || value.empty? }.keys
  end
end
