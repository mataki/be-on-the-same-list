module UsersHelper

  def link_to_update_status(user)
    link_to update_status_on_twitter_url(".@#{user.screen_name} は @#{user.no_1_user.screen_name} と一番たくさん同じリストに入れられています。 #{shrink_url(user)}"), :class => "tweet_result" do
      image_tag('twitter.gif') + "結果をつぶやく"
    end unless user.cal_users_lists_table.blank?
  end

  def shrink_url(user)
    "http://bsl.mat-aki.net/#{user.screen_name}"
  end
end
