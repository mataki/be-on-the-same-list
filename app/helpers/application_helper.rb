# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def twitter_url(screen_name)
    "http://twitter.com/#{h screen_name}"
  end

  def update_status_on_twitter_url(status, options = {})
    uri = URI.join("http://twitter.com/")
    query = options.update(:status => status)
    uri.query = query.to_query
    uri.to_s
  end
end
