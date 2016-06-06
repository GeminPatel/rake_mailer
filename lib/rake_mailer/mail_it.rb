module RakeMailer
  class MailIt < ActionMailer::Base
    def custom_text_email(from, to, file_location, filename, subject)
      attachments[filename] = File.read(file_location)
      mail :from => from,
           :to => to,
           :subject => subject do |format|
        format.text { render text: 'PFA' }
      end
    end
  end
end