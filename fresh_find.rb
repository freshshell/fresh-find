require 'octokit'

def client
  @client ||= Octokit::Client.new(
    :login => ENV['LOGIN'],
    :password => ENV['PASSWORD']
  )
end

def items
  @items ||= client.search_code('path:freshrc', :per_page => 1000).items
end

items.each do |item|
  content = Base64.decode64 client.contents(item.repository.full_name, :path => item.path).content
  lines = content.lines.select { |line| line.match /^\s*fresh/ }.map &:strip
  # TODO: check these lines work and add them to the fresh directory
end
