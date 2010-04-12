class User < ActiveRecord::Base
  has_many :lists, :through => :user_lists
  has_many :user_lists

  def process(client)
    if self.fetched_at.blank? or self.fetched_at < 1.day.ago
      [:fetch_memberships, self.fetch_memberships(client).map(&:full_name)]
    else
      result = self.lists.each do |list|
        if list.fetched_at.blank? or list.fetched_at < 1.day.ago
          list.fetch_list_members(client)
          break [:fetch_list_members, list.full_name]
        end
      end
      if result.first == :fetch_list_members
        result
      else
        [:complete, ""]
      end
    end
  end

  def fetch_memberships(client)
    logger.info "Fetch memberships"
    memberships = client.memberships(self.screen_name)
    logger.info "memberships :#{memberships.lists.count}"
    lists = memberships.lists.map do |list|
      l = List.find_or_create_by_response(list)
      l.user_lists.find_or_create_by_user_id(self.id)
      l
    end
    self.touch(:fetched_at)
    lists
  end

  def self.find_or_create_by_response(user)
    self.find_or_create_by_screen_name(user.screen_name) do |u|
      u.profile_image_url = user.profile_image_url
    end
  end

  def cal_users_lists_table
    list_user_arr = lists.inject([]) do |arr, list|
      arr + list.users.map{ |user| [user, list] }
    end.reject{ |i| i[0].screen_name == self.screen_name }
    list_user_arr.group_by{ |ar| ar[0].screen_name }.map{ |k,v| [v.first[0], v.map{|i| i[1]}, v.size]}.sort{ |a,b| a[2] <=> b[2]}.reverse
  end
end
