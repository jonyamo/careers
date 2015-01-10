# Careers

Gem to wrap [Stack Overflow Careers](https://careers.stackoverflow.com/)
[feed](https://careers.stackoverflow.com/jobs/feed)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'careers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install careers

## Usage

The Careers gem fetches jobs from Stack Overflow Careers using the provided RSS feed.
To fetch jobs call the `fetch` method, either with no args (to fetch all jobs) or pass
a hash of filters (see Available filters section below) to narrow the results. The result
set is a list of `Careers::Feed::Entry` objects.

- Fetch all jobs

```ruby
Careers::Feed.fetch
# => [<Careers::Feed::Entry:0x007f78a53ffd70
# @allows_remote=false,
# @categories=["java", "jee", "oracle", "design", "patterns"],
# @company="ADP",
# @guid="https://careers.stackoverflow.com/jobs/73396/principal-java-architect-adp",
# @job_title="Principal Java Architect",
# @location="Alpharetta, GA",
# @published_at=2015-01-10 22:15:12 UTC,
# @summary="...",
# @title="Principal Java Architect at ADP (Alpharetta, GA)",
# @url="https://careers.stackoverflow.com/jobs/73396/principal-java-architect-adp">,
# ...]
```
- Fetch jobs using filters

```ruby
Careers::Feed.fetch({ keywords: "ruby", location: "new york" })
# => [#<Careers::Feed::Entry:0x007f78a69ded08
# @allows_remote=false,
# @categories=["java", "ruby", "python", "c#", "scala"],
# @company="Cyrus Innovation",
# @guid="https://careers.stackoverflow.com/jobs/76059/senior-ruby-developer-cyrus-innovation",
# @job_title="Senior Ruby Developer",
# @location="New York, NY",
# @published_at=2015-01-10 19:20:04 UTC,
# @summary="...",
# @title="Senior Ruby Developer at Cyrus Innovation (New York, NY)",
# @url="https://careers.stackoverflow.com/jobs/76059/senior-ruby-developer-cyrus-innovation">,
# ...]
```
## Available filters:

Filter | Type
------ | ----
keywords | String
search_term (_alias for keywords_) | String
location | String
allows_remote | Boolean
offers_relocation | Boolean

## Contributing

1. Fork it ( https://github.com/jonyamo/careers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
