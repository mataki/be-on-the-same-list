class TwitterUtil

  def initialize(client, user_id)
    @client = client
    @user_id = user_id
  end

  attr_reader :client, :user_id

  def be_on_the_same_list
    memberships = client.memberships(user_id)
    #memberships = client.lists(user_id) # for test

    lists = memberships.lists

    puts "Approch list: #{lists.count}"

    list_user_arr = lists.inject([]) do |arr, list|
      puts "get list #{list.full_name}"
      owner, list_slug = list.user.screen_name, list.slug
      members = client.list_members(owner, list_slug)
      arr + members.users.map{ |user| [user, list]}
    end.reject{ |i| i[0].screen_name == user_id }

    group = list_user_arr.group_by{ |ar| ar[0].screen_name }
    sorted = group.map{|k,v| [v.first[0], v.map{|i| i[1]}, v.size]}.sort{|a,b| a[2] <=> b[2]}.reverse
    sorted
  end
end
