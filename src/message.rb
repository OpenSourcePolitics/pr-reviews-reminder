require "rocketchat"
require_relative 'name_helper'

module Message
  def self.post(pull_request, reviewer)

    recipient = NameHelper.find(reviewer).rocket_name
    puts "Posting message to @#{recipient} for #{pull_request[:title]}"

    title = "A request is waiting for your review @#{recipient}"
    attachment = {
      title: pull_request[:title],
      title_link: pull_request[:url],
      text: "Please review this pull request shortly ! :pray:",
      color: "#FF0000"
    }

    return if client.nil?

    client.chat.post_message(channel: ENV["ROCKET_CHANNEL"], text: title, attachments: [attachment], alias: "Github Reviewer Reminder", emoji: ":robot_face:")
  end

  def self.client
    return @client if @client

    rocket_server = RocketChat::Server.new(ENV['ROCKET_URL'])
    @client = rocket_server.login(ENV["ROCKET_USERNAME"], ENV["ROCKET_PASSWORD"])
  rescue => e
    # Unauthorized or HTTPError, StatusError
    puts "reason: #{e.message}"
    @client = nil
  end
end