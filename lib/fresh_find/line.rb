require 'octokit'

module FreshFind
  class Line
    ACCESS_TOKEN = ENV.fetch 'ACCESS_TOKEN'

    def self.all
      new.call
    end

    def client
      @client ||= Octokit::Client.new access_token: ACCESS_TOKEN
    end

    def items
      @items ||= client.search_code("fresh filename:freshrc", per_page: 100).items
    end

    def call
      items.each do |item|
        content = Base64.decode64 client.contents(item.repository.full_name, path: item.path).content
        lines = content.lines.select { |line| line.match /^\s*fresh/ }.map &:strip
        lines.each do |line|
          p line
        end
        # TODO: check these lines work and add them to the fresh directory
        #
        # NOTE: these lines contain "fresh-options" which means we probably need to
        # parse the file with fresh to add any options.
      end
    end
  end
end
