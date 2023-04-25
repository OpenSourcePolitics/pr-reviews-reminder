require_relative "github"
require_relative 'name_helper'
require_relative 'message'
require 'sinatra'
require "parallel"

get '/' do
  return { status: 401, message: "Unauthorized" }.to_json unless params[:token] == ENV["API_TOKEN"]
  start_time = Time.now
  logger.info "Starting scan"

  client = Github.new

  logger.info "Scanning repositories, found: #{client.repositories.count}"
  logger.info "Scanning unanswered pull requests, found: #{client.unanswered_pull_requests.count}"

  statuses = Parallel.map(client.unanswered_pull_requests, in_threads: 4) do |pull_request|
    Parallel.map(pull_request[:pending_reviewers], in_threads: 4) do |reviewer|
      logger.info "Sending message to #{reviewer} for #{pull_request[:repository]}##{pull_request[:pull_request]}"
      Message.post(pull_request, reviewer)
    end
  end.flatten.compact

  end_time = Time.now

  logger.info "Elapsed time: #{end_time - start_time}"

  { status: 200, statuses: statuses, elapsed_time: (end_time - start_time) }.to_json
end