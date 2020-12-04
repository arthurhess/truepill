# Truepill API Client

A ruby gem for the Truepill API.

Truepill API documentation: https://docs.truepill.com/#introduction

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'truepill_api_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install truepill_api_client

## Usage

First configure the environment and credentials.

In a Rails app, this might go in `config/initializers/truepill.rb` for example.

```ruby
Truepill.configure do |config|
  config.environment = Rails.env.production? ? :production : :sandbox
  config.client_id = ENV['TRUEPILL_CLIENT_ID']
  config.client_secret = ENV['TRUEPILL_CLIENT_SECRET']
  config.persist_token = lambda do |value|
    Rails.cache.write("truepill_access_token", value)
  end
  config.persisted_token = lambda do
    Rails.cache.read("truepill_access_token")
  end
end
```

Access tokens are valid for 3600 seconds (60 minutes) as of this writing. You will need to obtain a new access token if the previous one has expired.

Test the API by hitting the /ping endpoint (continued from above example):

```ruby
Truepill::Request.new.ping?
# => true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cerebral-inc/truepill\_api\_client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
