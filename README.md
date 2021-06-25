# Herokenv

Easily pull Heroku environment variables into non-Heroku environments.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'herokenv'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install herokenv

## Usage

Before or during the boot stage of your app you can require `herokenv` and have it populate your ENV
based on the values in a Heroku app.

```ruby
require 'herokenv'
herokenv = Herokenv::Client.new(oauth_token: 'xxx', app: '')
herokenv.populate_env_from_app('your-heroku-app-name')
```

Now your local process will have access to ENV vars that are set in your heroku app.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/herokenv. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/herokenv/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Herokenv project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/herokenv/blob/master/CODE_OF_CONDUCT.md).
