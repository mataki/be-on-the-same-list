class OauthController < ApplicationController

  def request_token
    oauth.set_callback_url("#{root_url}oauth/access_token")
    request_token = oauth.request_token
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def access_token
    oauth_params = session[:request_token], session[:request_token_secret], params[:oauth_verifier]
    reset_session
    session[:atoken], session[:asecret] = oauth.authorize_from_request(*oauth_params)
    user = client.verify_credentials
    session[:screen_name] = user.screen_name

    redirect_to root_url
  end
end
