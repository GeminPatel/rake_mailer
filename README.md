# RakeMailer

## Badges
[![Gem Version](https://badge.fury.io/rb/rake_mailer.svg)](https://badge.fury.io/rb/rake_mailer)

[![Maintainability](https://api.codeclimate.com/v1/badges/1e212f6ddf651f14eaa1/maintainability)](https://codeclimate.com/github/GeminPatel/rake_mailer/maintainability)

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

### Configuration Details:
    'from'- It is compulsory. It must be a string.
    'emails'- It is compulsory if a email has to be sent somewhere.
        It can we a string or an array of strings
    'file_path'- system path where the rake mailer can store its generated reports.
        By default it uses tmp/rake_mailer in the app's root directory
    'display_system_info'- By default it is set to true. If true it will send some 
        system information in the body of the email.


## Usage

### Create a rake_mailer.yml in config
    development:
      from: 'gemin.patel61@gmail.com'
      emails: ['arjun.verma@gmail.com', 'kamal.soni@gmail.com']
      file_path: 'tmp/rake_mailer'
      display_system_info: true

### Sample Rake Task will now look like
    namespace :bug_fixes do
      task test: :environment do
        r = RakeMailer::FileWriter.new
        users = User.all
        r.file_writer("Total users found: #{users.count}")
        r.close
      end
    end

### Action Mailer Setting:
    Add code like below to your application.rb file:
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'example.com',
      user_name:            '<username>',
      password:             '<password>',
      authentication:       'plain',
      enable_starttls_auto: true  }

    For more details visit: http://guides.rubyonrails.org/action_mailer_basics.html

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
