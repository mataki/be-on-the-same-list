# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :atoken, :asecret

  helper_method :logged_in?

  before_filter :set_session_screen_name, :redirect_shrink_url

private
  def set_session_screen_name
    if session[:atoken] and session[:screen_name].blank?
      user = client.verify_credentials
      session[:screen_name] = user.screen_name
    end
  end

  def redirect_shrink_url
    redirect_to url_for(:host => "be-on-the-same-list.mat-aki.net") if request.host == "bsl.mat-aki.net"
  end

  def oauth
    @oauth ||= Twitter::OAuth.new("je9vO22hV3R3gPPOnVjAw", "JeDon8wgdLhUHKnFRwOQLFtc11XoPkNEeudUlI1e8")
  end

  def client
    return @client if @client
    oauth.authorize_from_access(session[:atoken], session[:asecret])
    @client = Twitter::Base.new(oauth)
  end

  def logged_in?
    session[:atoken] and session[:asecret]
  end
end
