# Geezify::Rb

Geezify-rb is a gem that converts geez-script numbers to arabic and viceversa.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'geezify-rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geezify-rb

## Usage

```
Geezify-rb::geezify(12)                   #=> '፲፪'
Geezify-rb::geezify(3033)                 #=> '፴፻፴፫'
Geezify-rb::geezify(100200000)            #=> '፼፳፼'
Geezify-rb::geezify(333333333)            #=> '፫፼፴፫፻፴፫፼፴፫፻፴፫'
Geezify-rb::Arabify('፲፪')                 #=> 12
Geezify-rb::Arabify('፴፻፴፫')               #=> 3033
Geezify-rb::Arabify('፼፳፼')                #=> 100200000
Geezify-rb::Arabify('፫፼፴፫፻፴፫፼፴፫፻፴፫')      #=> 333333333
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yilkalargaw/geezify-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Geezify::Rb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yilkalargaw/geezify-rb/blob/master/CODE_OF_CONDUCT.md).
