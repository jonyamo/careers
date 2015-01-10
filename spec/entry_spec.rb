require_relative "spec_helper"
require "ostruct"

RSpec.describe Careers::Feed::Entry do
  before  { @entry = Careers::Feed::Entry.new }
  subject { @entry }

  it { should respond_to :guid }
  it { should respond_to :url }
  it { should respond_to :title }
  it { should respond_to :summary }
  it { should respond_to :job_title }
  it { should respond_to :company }
  it { should respond_to :location }
  it { should respond_to :allows_remote }
  it { should respond_to :categories }
  it { should respond_to :published_at }

  describe ".build" do
    it "should build a valid Entry object" do
      guid = "https://example.com/job/1"
      link = guid
      title = "Job Title at Company (Location) (allows remote)"
      description = "Job Summary"
      pub_date = Time.now

      entry = Careers::Feed::Entry.build(OpenStruct.new(
        guid: OpenStruct.new(content: guid),
        link: link,
        title: title,
        description: description,
        categories: [
          OpenStruct.new(content: "cat1"),
          OpenStruct.new(content: "cat2")
        ],
        pubDate: pub_date ))

      expect(entry).to be_a Careers::Feed::Entry
      expect(entry.guid).to eq guid
      expect(entry.url).to eq link
      expect(entry.title).to eq title
      expect(entry.summary).to eq description
      expect(entry.job_title).to eq "Job Title"
      expect(entry.company).to eq "Company"
      expect(entry.location).to eq "Location"
      expect(entry.allows_remote).to be true
      expect(entry.published_at).to eq pub_date
      expect(entry.categories).to eq ["cat1", "cat2"]
    end
  end

  describe ".tokenize_title" do
    context "with a standard title" do
      title = "Job Title at Company (Location)"
      tokens = Careers::Feed::Entry.tokenize_title(title)

      it "sets all tokens correctly" do
        expect(tokens[:job_title]).to eq("Job Title")
        expect(tokens[:company]).to eq("Company")
        expect(tokens[:location]).to eq("Location")
        expect(tokens[:allows_remote]).to be false
      end
    end

    context "with extra parens in the job title" do
      title = "Job Title (Extra) at Company (Location)"
      tokens = Careers::Feed::Entry.tokenize_title(title)

      it "sets all tokens correctly" do
        expect(tokens[:job_title]).to eq("Job Title (Extra)")
        expect(tokens[:company]).to eq("Company")
        expect(tokens[:location]).to eq("Location")
        expect(tokens[:allows_remote]).to be false
      end
    end

    context "when allows remote is present" do
      title = "Job Title at Company (Location) (allows remote)"
      tokens = Careers::Feed::Entry.tokenize_title(title)

      it "sets all tokens correctly" do
        expect(tokens[:job_title]).to eq("Job Title")
        expect(tokens[:company]).to eq("Company")
        expect(tokens[:location]).to eq("Location")
        expect(tokens[:allows_remote]).to be true
      end
    end

    context "when multiple locations are present" do
      title = "Job Title at Company (Location; Location 2) (allows remote)"
      tokens = Careers::Feed::Entry.tokenize_title(title)

      it "sets all tokens correctly" do
        expect(tokens[:job_title]).to eq("Job Title")
        expect(tokens[:company]).to eq("Company")
        expect(tokens[:location]).to eq("Location; Location 2")
        expect(tokens[:allows_remote]).to be true
      end
    end
  end
end
