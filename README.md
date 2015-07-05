# Aegisubkit

A Parser for Aegisub subtitle file in ruby


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aegisubkit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aegisubkit

## Usage

    @file_path = File.expand_path('../../fixtures/example.ass', __FILE__)
    @result = Aegisubkit::ASS.import(@file_path)

    @result.info           # script info
    @result.events         # events
    @result.audio_metadata # audio file metadata

see also `lib/aegisubkit/ass.rb`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/aegisubkit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
