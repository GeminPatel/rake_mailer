require 'socket'
module RakeMailer
  class MailIt < ActionMailer::Base
    def custom_text_email(from, to, file_location, filename, subject)
      attachments[filename] = File.read(file_location)
      mail :from => from,
           :to => to,
           :subject => subject do |format|
        format.text { render text: body_text }
      end
    end
    private
    def body_text
      s = ''
      s << "IP: #{Socket.ip_address_list.find {|a| !(a.ipv4_loopback?) }.ip_address}\n"
      s << "Host Name: #{Socket.gethostname}\n"
      s << "User: #{ENV['USERNAME']}\n"
      s << "Time: #{Time.now}\n"
      begin
        output = %x(free)
        s << "Total Memory: #{output.split(" ")[7]}\n"
        s << "User Memory: #{output.split(" ")[8]}\n"
        s << "Free Memory: #{output.split(" ")[9]}\n"
      rescue
      end
      s << "pfa\n"
      s
    end
  end
end


