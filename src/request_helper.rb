module RequestHelper
  def self.search_body_for(request, key)
    parse_body(request)[key]
  end

  def self.parse_body(request)
    JSON.parse(request.body.read)
  end
end