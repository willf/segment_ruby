# SegmentRuby

SegmentRuby is a module for segmenting (English)
text based on various language models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'segment_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install segment_ruby

## Usage

```
require 'segment_ruby'
t = SegmentRuby::Analyzer.new(:twitter)
t.segment("theboywholived")
=> ["the", "boy", "who", "lived"]
```
Models include:

- `:norvig`: based on Google web data
- `:google_books`: based on Google books data
- `:anchor`: based on Web anchor text
- `:twitter`: based on Twitter data
- `:small`: smaller version of the Google books data

The default model is `small`. Use it if is seems to work for you.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/willf/segment_ruby.
