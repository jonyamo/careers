module Careers
  module Feed
    URL = "https://careers.stackoverflow.com/jobs/feed"

    def self.fetch
      feed.items.collect do |item|
        Entry.build item
      end
    end

    private

    def self.conn
      Faraday.new(:url => URL) do |faraday|
        faraday.adapter :typhoeus
      end
    end

    def self.feed
      response = conn.get
      RSS::Parser.parse response.body
    end
  end
end
