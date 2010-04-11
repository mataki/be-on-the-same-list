ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home"

  map.logout "/logout", :controller => "home", :action => "logout"

  map.request_token "oauth/request_token", :controller => "oauth", :action => "request_token"
  map.access_token "oauth/access_token", :controller => "oauth", :action => "access_token"

  map.users "/:name", :controller => "users", :action => "show"
end
