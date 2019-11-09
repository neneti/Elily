# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = '登録が完了しました。'
      redirect_to user
    else
      flash[:danger] = '登録できませんでした。'
      redirect_to root_url
    end
  end
end
