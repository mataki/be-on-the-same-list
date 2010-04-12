require 'spec_helper'

describe List do
  before(:each) do
    @valid_attributes = {

    }
  end

  describe "#fetch_list_members" do
    before do
      @list = List.create(:uri => "/mat_aki/sonicgarden", :full_name => "@mat_aki/sonicgarden")
    end
    it "ユーザが作成されること" do
      lambda do
        @list.fetch_list_members(client)
      end.should change(User, :count)
    end
    it "関連が作成されること" do
      lambda do
        @list.fetch_list_members(client)
      end.should change(UserList, :count)
    end
    it "fetch時間が今になること"
  end

  def client
    return @client if @client
    httpauth = Twitter::HTTPAuth.new("mat_aki_test", "passtest")
    @client = Twitter::Base.new(httpauth)
  end

end
