require 'octokit'

def access_token
  ENV.fetch 'ACCESS_TOKEN'
end

def client
  @client ||= Octokit::Client.new access_token: access_token
end

def items
  @items ||= client.search_code("fresh filename:freshrc", per_page: 100).items
end

items.each do |item|
  content = Base64.decode64 client.contents(item.repository.full_name, path: item.path).content
  lines = content.lines.select { |line| line.match /^\s*fresh/ }.map &:strip
  # TODO: check these lines work and add them to the fresh directory
  #
  # NOTE: these lines contain "fresh-options" which means we probably need to
  # parse the file with fresh to add any options.
end
