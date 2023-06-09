# frozen_string_literal: true

require 'rocketchat'
require_relative 'name_helper'

# This is a helper class to send messages to rocket chat.
module Message
  def self.post(pull_request, reviewer)
    recipient = NameHelper.find(reviewer).rocket_name
    title = "A request is waiting for your review @#{recipient}"
    attachment = {
      title: pull_request[:title],
      title_link: pull_request[:url],
      text: 'Please review this pull request shortly ! :pray:',
      color: '#FF0000'
    }

    return if client.nil?

    client.chat.post_message(channel: EnvironmentHelper.for(:rocket_channel), text: title, attachments: [attachment],
                             alias: 'Github Reviewer Reminder', emoji: ':robot_face:')

    { pull_request:, reviewer:, recipient:, title:, attachment: }
  end

  def self.client
    return @client if @client

    rocket_server = RocketChat::Server.new(EnvironmentHelper.for(:rocket_url))
    @client = rocket_server.login(EnvironmentHelper.for(:rocket_username), EnvironmentHelper.for(:rocket_password))
  rescue StandardError => e
    # Unauthorized or HTTPError, StatusError
    puts "reason: #{e.message}"
    @client = nil
  end
end
