module Careers
  module Feed
    class Entry
      REGEX = { :allows_remote => /\s\(allows remote\)/,
                :location      => /\s\(([^\)]+)\)$/ }

      attr_reader :guid, :url, :title, :summary, :job_title,
                  :company, :location, :allows_remote, :published_at,
                  :categories

      def initialize(attrs={})
        @guid = attrs[:guid]
        @url = attrs[:url]
        @title = attrs[:title]
        @summary = attrs[:summary]
        @job_title = attrs[:job_title]
        @company = attrs[:company]
        @location = attrs[:location]
        @allows_remote = attrs[:allows_remote]
        @published_at = attrs[:published_at]
        @categories = attrs[:categories]
      end

      # Given an object, massages the attributes into an instance of this class.
      def self.build(item)
        tokens = tokenize_title(item.title.dup)
        new({ guid: item.guid.content,
              url: item.link,
              title: item.title,
              summary: item.description,
              job_title: tokens[:job_title],
              company: tokens[:company],
              location: tokens[:location],
              allows_remote: tokens[:allows_remote],
              categories: item.categories.collect { |category| category.content },
              published_at: item.pubDate })
      end

      # Given a string of the format "Job Title at Company (Location) [(allows remote)]",
      # parses and separates it into sections. Returns a hash of the resulting sections.
      def self.tokenize_title(str)
        tokens = {}

        # allows remote?
        tokens[:allows_remote] = str.sub!(REGEX[:allows_remote], "") ? true : false

        # locations
        tokens[:location] = ""
        matches = str.match REGEX[:location]
        if not matches.nil?
          tokens[:location] = matches[1]
          str.sub!(REGEX[:location], "")
        end

        # job title and company
        tokens[:job_title], tokens[:company] = str.split(" at ")

        tokens
      end
    end
  end
end
