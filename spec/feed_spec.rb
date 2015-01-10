require_relative "spec_helper"
require_relative "support/vcr"

RSpec.describe Careers::Feed do
  it "should have the correct endpoint" do
    expect(Careers::Feed::URL).to eq "https://careers.stackoverflow.com/jobs/feed"
  end

  describe ".conn" do
    it "should return an instance of Faraday::Connection" do
      expect(Careers::Feed.conn).to be_a Faraday::Connection
    end
  end

  describe ".feed", :vcr do
    before { @feed = Careers::Feed.feed }

    it "should return an instance of RSS::Rss" do
      expect(@feed).to be_a RSS::Rss
    end

    it "should respond to expected methods" do
      @feed.items.each do |item|
        expect(item).to respond_to :guid
        expect(item).to respond_to :link
        expect(item).to respond_to :title
        expect(item).to respond_to :description
        expect(item).to respond_to :pubDate
      end
    end
  end

  describe ".fetch", :vcr do
    before { @entries = Careers::Feed.fetch }

    it "returns a list of Careers::Feed::Entries" do
      expect(@entries).not_to be_empty
      expect(@entries).to all be_a Careers::Feed::Entry
    end
  end

  describe ".validate_filters!" do
    it "should remove unknown filters" do
      filters = { location: "one", foo: "three" }
      Careers::Feed.validate_filters!(filters)
      expect(filters).to eq({ location: "one" })
    end

    it "should replace nicley formatted keys with keys that make no sense" do
      filters = { search_term: "one", allows_remote: "two" }
      Careers::Feed.validate_filters!(filters)
      expect(filters).to eq({ searchTerm: "one", allowsremote: "two" })
    end
  end
end
