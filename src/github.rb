require "octokit"
require "parallel"

class Github
  def initialize
    @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])#.tap { |client| client.auto_paginate = true }
  end

  def repositories
    return @repositories if @repositories

    repositories = @client.organization_repositories(organization.login)
    repositories.concat(@client.get(@client.last_response.rels[:next].href)) while @client.last_response.rels[:next]

    @repositories = repositories
  end

  def unanswered_pull_requests
    @unanswered_repositories ||= Parallel.map(@repositories, in_threads: 4) do |repo|
      Parallel.map(@client.pull_requests(repo.full_name, state: "open"), in_threads: 8) do |pull_request|
        {
          repository: repo.full_name,
          pull_request: pull_request.number,
          url: pull_request.html_url,
          api_url: pull_request.url,
          title: pull_request.title,
          pending_reviewers: pending_reviewers(repo, pull_request)
        }
      end
    end.flatten.compact.reject { |pull_request| pull_request[:pending_reviewers].empty? }
  end

  def organization
    @client.list_organizations.select { |org| org.login == ENV["ORGANIZATION"] }.first
  end

  def pending_reviewers(repo, pull_request)
    requests = @client.pull_request_review_requests(repo.full_name, pull_request.number).users.map(&:login)
    reviews = @client.pull_request_reviews(repo.full_name, pull_request.number).map(&:user).map(&:login)

    requests - reviews
  end
end