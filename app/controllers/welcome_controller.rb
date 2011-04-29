class WelcomeController < ApplicationController
  def index
  end

  def dashboard
    unless signed_in?
      redirect_to root_path
    else
      @user = current_user
    end
  end

end
