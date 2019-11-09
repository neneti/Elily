# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'elily.herokuapp.com'
  layout 'mailer'
end
