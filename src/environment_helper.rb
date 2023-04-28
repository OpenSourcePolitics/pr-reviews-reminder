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
    @names_map = ENV["NAMES_MAP"]
    @rocket_channel = ENV["ROCKET_CHANNEL"]
    @rocket_url = ENV["ROCKET_URL"]
    @rocket_username = ENV["ROCKET_USERNAME"]
    @rocket_password = ENV["ROCKET_PASSWORD"]
    @github_access_token = ENV["GITHUB_ACCESS_TOKEN"]
    @organization = ENV["ORGANIZATION"]
    @api_token = ENV["API_TOKEN"]
  end

  def configuration
    @configuration ||= self.instance_variables.each_with_object({}) do |var, hash|
      hash[var.to_s.delete("@").to_sym] = self.instance_variable_get(var)
    end
  end

  def missing_configuration
    configuration.select { |_, value| value.nil? || value.empty? }.keys
  end
end