# frozen_string_literal: true

#
# The Base Application Mailer
#
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
