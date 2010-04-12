class List < ActiveRecord::Base
  has_many :users, :through => :user_lists
  has_many :user_lists

  def self.find_or_create_by_response(response)
    self.find_or_create_by_full_name(response.full_name) do |list|
      list.uri = response.uri
    end
  end

  def fetch_list_members(client)
    _, owner, list_slug = self.uri.split('/')
    members = client.list_members(owner, list_slug)
    users = members.users.map do |user|
      u = User.find_or_create_by_response(user)
      u.user_lists.find_or_create_by_list_id(self.id)
      u
    end
    self.touch(:fetched_at)
    users
  end
end
