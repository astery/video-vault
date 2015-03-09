class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{Rails.application.secrets.domain_name}"
  layout 'mailer'
end
