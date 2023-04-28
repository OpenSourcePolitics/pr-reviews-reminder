# frozen_string_literal: true

# This is a helper class for the incoming request.
module RequestHelper
  # Search the body of the request for a given key.
  def self.search_body_for(request, key)
    parse_body(request)[key]
  end

  def self.parse_body(request)
    JSON.parse(request.body.read)
  end

  def self.authorized?
    search_body_for(request, 'token') == EnvironmentHelper.for(:api_token)
  end
end
