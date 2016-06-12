require 'socket'
module RakeMailer
  class MailIt < ActionMailer::Base
    def custom_text_email(from, to, file_location, filename, subject, display_system_info)
      attachments[filename] = File.read(file_location)
      body = display_system_info ? (body_text rescue "System Info Unsuccessful\n\npfa") : 'pfa'
      mail :from => from,
           :to => to,
           :subject => subject do |format|
        format.text { render text: body }
      end
    end

    private
    def body_text
      s = "GENERAL INFO\n"
      s << "\tIP: #{Socket.ip_address_list.find {|a| !(a.ipv4_loopback?) }.ip_address}\n"
      s << "\tHost: #{Socket.gethostname}\n"
      s << "\tUser: #{ENV['USERNAME']}\n\n"
      s << "\nTIME INFO\n"
      s << "\tTime: #{Time.now.asctime}\n\n"
      db_config = Rails.configuration.database_configuration[Rails.env]
      s << "\nDATABASE INFO\n"
      s << "\tAdapter: #{db_config['adapter']}\n"
      s << "\tDatabase: #{db_config['database']}\n"
      s << "\tHost: #{db_config['host']}\n\n"
      begin
        s << "\nSYSTEM INFO\n"
        output = %x(free)
        s << "\tTotal Memory: #{output.split(" ")[7]} KB\n"
        s << "\tUsed Memory: #{output.split(" ")[8]} KB\n"
        s << "\tFree Memory: #{output.split(" ")[9]} KB\n"
      rescue
        puts "ERROR: Block in body_text. Could not run command 'free' => #{e.message}"
      end
      s << "\npfa\n"
      s << "\n\nregards,\n"
      s << "Rake Mailer\n"
      s
    end
  end
end


