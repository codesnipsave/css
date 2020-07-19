class ApplicationMailer < ActionMailer::Base
  default from: 'test@mailinator.com'
  layout 'mailer'
end
