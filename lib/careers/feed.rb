module Careers
  module Feed
    URL = "https://careers.stackoverflow.com/jobs/feed"
    FILTERMAP = { search_term: :searchTerm,
                  location: :location,
                  allows_remote: :allowsremote,
                  offers_relocation: :offersrelocation }

    def self.fetch(filters={})
      feed(filters).items.collect do |item|
        Entry.build item
      end
    end

    private

    def self.conn
      Faraday.new(:url => URL) do |faraday|
        faraday.adapter :typhoeus
      end
    end

    def self.feed(filters={})
      validate_filters!(filters)
      response = conn.get "", filters
      RSS::Parser.parse response.body
    end

    def self.validate_filters!(filters)
      filters.keep_if { |k, v| FILTERMAP.key? k }
      filters.keys.each { |k| filters[ FILTERMAP[k] ] = filters.delete(k) }
    end
  end
end
