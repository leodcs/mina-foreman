# Mina::Foreman

This is a fork of Foreman plugin for [mina](https://github.com/mina-deploy/mina), updated with looser Mina version requirement & support of Systemd based distributions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-foreman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina-foreman

## Usage

   require 'mina/foreman'

   task :deploy => :environment do
     deploy do
       ...
       invoke 'foreman:export'
       ...
     end

     to :launch do
       invoke 'foreman:restart'
     end
   end

# Configuration

    set :foreman_app # default:  -> { "#{fetch(:application_name)}" }
    set :foreman_user # default: -> { user }
    set :foreman_log # default:  -> { "#{deploy_to!}/#{shared_path}/log" }
    set :foreman_sudo # default: true
    set :foreman_format # default: 'systemd'
    set :foreman_procfile # default: 'Procfile'

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mina-foreman. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
