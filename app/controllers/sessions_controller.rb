class SessionsController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :destroy]}
  def new
    if logged_in?
      redirect_to posts_path
    end
  end

  def create
    
  end
  
  def destroy
    
  end  
end
