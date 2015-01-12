module Careers
  module Feed
    URL = "https://careers.stackoverflow.com/jobs/feed"
    FILTERMAP = { keywords: :searchTerm,
                  search_term: :searchTerm,
                  location: :location,
                  allows_remote: :allowsremote,
                  offers_relocation: :offersrelocation }

    # Fetches current job listings using supplied filters, if any.
    # Returns a list of Careers::Feed::Entry objects.
    def self.fetch(filters={})
      feed(filters).items.collect do |item|
        Entry.build item
      end
    end

    private

    # Establishes and returs a connection object.
    def self.conn
      Faraday.new(:url => URL) do |faraday|
        faraday.adapter :typhoeus
      end
    end

    # Fetches raw feed, parses it, and returns the result.
    def self.feed(filters={})
      validate_filters!(filters)
      response = conn.get "", filters
      RSS::Parser.parse response.body
    end

    # Given a hash, it first removes any keys that are not found in FILTERMAP.
    # Then, replaces any keys that have a match in FILTERMAP.
    #
    # The service endpoint expects params that seem to have no standard format,
    # and do not follow any sort of Ruby style. So, the point of the replacement
    # is to provide to the user of this gem params styled in a format they would
    # be familiar with.
    #
    # See Careers::Feed::FILTERMAP for available filters.
    def self.validate_filters!(filters)
      filters.keep_if { |k, v| FILTERMAP.key? k }
      filters.keys.each { |k| filters[ FILTERMAP[k] ] = filters.delete(k) }
    end
  end
end
