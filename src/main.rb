require_relative "github"
require_relative 'name_helper'
require_relative 'message'

client = Github.new

puts "Repositories: #{client.repositories.count}"
puts "Unanswered Pull Requests: #{client.unanswered_pull_requests.count}"

client.unanswered_pull_requests.each do |pull_request|
  pull_request[:pending_reviewers].each do |reviewer|
    Message.post(pull_request, reviewer)
  end
end