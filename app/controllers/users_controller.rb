class UsersController < ApplicationController

  def show
    @user = User.find_by_screen_name(params[:name])

    render "process" unless @user and !@user.fetched_at.blank? and @user.fetched_at > 1.day.ago
  end

  def fetch
    if session[:atoken]
      @user = User.find_or_create_by_screen_name(params[:name])
      render :json => @user.process(client)
    else
      render :json => ["notlogin", "Login required"]
    end
  end
end
