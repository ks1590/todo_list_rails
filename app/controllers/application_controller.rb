class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
    if current_user == nil
      flash[:notice] = "ログインが必要です。"
      redirect_to new_session_path
    end
  end
end
