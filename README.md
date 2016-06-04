# RakeMailer

## Badges
[![Coverage Status](https://coveralls.io/repos/github/GeminPatel/rake_mailer/badge.svg?branch=master)](https://coveralls.io/github/GeminPatel/rake_mailer?branch=master)
[![Gem Version](https://badge.fury.io/rb/rake_mailer.svg)](https://badge.fury.io/rb/rake_mailer)

Welcome to your new gem! This is a mailer gem to be used in rake tasks.
Please see the usage section for simple setup instructions and how to use this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rake_mailer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rake_mailer

## Usage

### Create a rake_mailer.yml in config
    development:
      from: 'gemin.patel61@gmail.com'
      emails: ['arjun.verma@gmail.com', 'kamal.soni@gmail.com']
      file_path: 'tmp/rake_mailer'

### Sample Rake Task will now look like
    namespace :bug_fixes do
      task test: :environment do
        r = RakeMailer::FileWriter.new
        users = User.all
        r.file_writer("Total users found: #{users.count}")
        r.close
      end
    end
  ```
  This will create a file 1465113400_bug_fixes:test.txt and mail it as an attachment. 
  Email settings will be used from rake_mailer.yml
  Must configure your application.rb or enviroments 'rb' files with action mailer setting.
  During initialization you can pass in 1 optional parameter for emails. It will over ride the default email list of config file.
  ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rake_mailer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
