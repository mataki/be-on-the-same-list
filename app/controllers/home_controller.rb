class HomeController < ApplicationController

  def index
    if session[:atoken]
      @user = client.verify_credentials
    end
  end

  def logout
    reset_session
    redirect_to root_url
  end
end
