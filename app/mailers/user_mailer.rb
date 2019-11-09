# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'アカウント有効化手続きのご案内'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'パスワード再設定手続きのご案内'
  end
end
