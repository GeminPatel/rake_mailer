require "rake_mailer/version"
require 'rubygems'
require 'action_mailer'
require File.expand_path('../rake_mailer/app/mailers/mail_it')
require 'fileutils'

module RakeMailer
  class FileWriter
    def initialize(emails = nil)
      @rake_mailer_constants = YAML.load_file("#{Rails.root}/config/rake_mailer.yml")[Rails.env]
      @from = @rake_mailer_constants['from']
      @emails = emails || @rake_mailer_constants['emails']
      @subject = "Rake Mailer:: Report for #{Rake.application.top_level_tasks.first}"
      config_file_path = @rake_mailer_constants['file_path']
      if (config_file_path.nil? || (config_file_path.is_a? String))
        @filename = Time.now.to_i.to_s + "_#{Rake.application.top_level_tasks.first}" + '.txt'
        FileUtils::mkdir_p(config_file_path || 'tmp/rake_mailer')
        @file_location = File.join(Rails.root, (config_file_path || 'tmp/rake_mailer'), @filename)
        @file = open(@file_location, 'w')
      else
        puts 'ERROR: gem rake_mailer => configuration file is incorrect'
      end
    end

    def file_writer(line)
      @file.write(line)
      @file.write("\n")
    end

    def close
      @file.close
      send_email
    end

    private
    def send_email
      if @from.present? && @emails.present? && ((@from.is_a? String) || (@from.is_a? Array)) && ((@emails.is_a? String) || (@emails.is_a? Array))
        MailIt.custom_text_email(@from, @emails, @file_location, @filename, @subject).deliver_now
      end
    end
  end
end
