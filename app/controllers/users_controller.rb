class UsersController < ApplicationController

  def show
    if session[:atoken]
      @list = TwitterUtil.new(client, params[:name]).be_on_the_same_list
    else
      redirect "/"
    end
  end
end
