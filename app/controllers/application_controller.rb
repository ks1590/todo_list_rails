class ApplicationController < ActionController::Base
  before_action :basic_auth

  protect_from_forgery with: :exception
  include SessionsHelper

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'test' && password == 'pass1234'
    end
  end

  def authenticate_user
    if current_user == nil
      flash[:notice] = "ログインが必要です。"
      redirect_to new_session_path
    end
  end
end
