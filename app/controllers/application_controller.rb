# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :atoken, :asecret

  def oauth
    @oauth ||= Twitter::OAuth.new("je9vO22hV3R3gPPOnVjAw", "JeDon8wgdLhUHKnFRwOQLFtc11XoPkNEeudUlI1e8")
  end

  def client
    return @client if @client
    oauth.authorize_from_access(session[:atoken], session[:asecret])
    @client = Twitter::Base.new(oauth)
  end
end
