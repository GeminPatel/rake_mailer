require "rake_mailer/version"
require 'rubygems'
require 'action_mailer'
require "rake_mailer/mail_it"
require 'fileutils'

module RakeMailer
  class FileWriter
    def initialize(emails = nil)
      load_yml
      set_email_config(emails)
      set_file_config
      create_file_path
      open_file         
    end

    def file_writer(line)
      begin
        @file.write(line)
        @file.write("\n")
      rescue Exception => e
        puts "ERROR: Block in file_writer. Rescued. Could not write in the file => #{e.message}"
      end  
    end

    def close
      begin
        @file.close
      rescue Exception => e
        puts "ERROR: Block in close. Rescued. Will attempt to send the mail. Could close the file => #{e.message}"
      end
      send_email
    end

    private
    def load_yml
      yml_file = YAML.load_file("#{Rails.root}/config/rake_mailer.yml")
      if yml_file && yml_file[Rails.env]
        @rake_mailer_constants = yml_file[Rails.env]
      else
        raise 'ERROR: gem rake_mailer => configuration file is incorrect'
      end
    end

    def set_email_config(emails)
      @emails = emails || @rake_mailer_constants['emails']
      @from = @rake_mailer_constants['from']
      @subject = "[Rake Mailer] Report for #{Rake.application.top_level_tasks.first}"
      set_display_system_info_config
    end

    def set_display_system_info_config
      @display_system_info = @rake_mailer_constants['display_system_info'].nil? ? true : @rake_mailer_constants['display_system_info']
    end

    def set_file_config
      @filename = Time.now.to_i.to_s + "_#{Rake.application.top_level_tasks.first}" + '.txt'
      @file_path = @rake_mailer_constants['file_path'] || 'tmp/rake_mailer'
      @file_location = File.join(Rails.root, (@file_path), @filename)
    end

    def create_file_path
      begin
        FileUtils::mkdir_p(@file_path)
      rescue Exception => e
        raise "ERROR: Block in create_file_path. Could not create folder => #{e.message}"
      end
    end

    def open_file
      begin
        @file = open(@file_location, 'w')
      rescue Exception => e
        raise "ERROR: Block in open_file. Could not open the file => #{e.message}"
      end
    end

    def send_email
      if @from.present? && @emails.present? && (@from.is_a? String) && ((@emails.is_a? String) || (@emails.is_a? Array))
        RakeMailer::MailIt.custom_text_email(@from, @emails, @file_location, @filename, @subject, @display_system_info).deliver_now
      end
    end
  end
end
