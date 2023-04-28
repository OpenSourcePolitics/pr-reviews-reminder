class NameHelper
  attr_reader :github_name, :rocket_name

  def self.find(name)
    github_to_rocket_chat.find { |name_helper| name_helper.github_name == name } || new(name, name)
  end

  def self.github_to_rocket_chat
    @github_to_rocket_chat ||= EnvironmentHelper.for(:names_map).split(",").map { |name| new(*name.split(":")) }
  end

  def initialize(github_name, rocket_name)
    @github_name = github_name
    @rocket_name = rocket_name
  end
end