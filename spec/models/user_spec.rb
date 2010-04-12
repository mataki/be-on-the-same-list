require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {

    }
  end

  describe "#fetch_memberships" do
    before do
      @user = User.create(:screen_name => "sgokamisan", :profile_image_url => "http://hogehoge.com/")
    end
    # it "リストが作成されること" do
    #   lambda do
    #     @user.fetch_memberships(client)
    #   end.should change(List, :count)
    # end
    # it "関連が作成されること" do
    #   lambda do
    #     @user.fetch_memberships(client)
    #   end.should change(UserList, :count)
    # end
    # it "fetch時間が今になること"
  end

  def client
    return @client if @client
    httpauth = Twitter::HTTPAuth.new("mat_aki_test", "passtest")
    @client = Twitter::Base.new(httpauth)
  end

  describe "#process" do
    before do
      @user = User.create(:screen_name => "sgokamisan", :profile_image_url => "http://hogehoge.com/")
    end
    describe "未取得の場合" do
      it "memberships を取得すること" do
        @user.should_receive(:fetch_memberships)
        @user.process(client)
      end
    end
    describe "時間が前の場合" do
      before do
        @user.fetched_at = 1.month.ago
      end
      it "memberships を取得すること" do
        @user.should_receive(:fetch_memberships)
        @user.process(client)
      end
      it "memberships を取得すること" do
        @user.stub(:fetch_memberships)
        result = @user.process(client)
        result.first.should == :fetch_memberships
      end
    end
    describe "最近取得している場合" do
      before do
        @user.fetched_at = 1.minute.ago
      end
      describe "すべて最近取得している場合" do
        before do
          @list = stub_model(List, :fetched_at => 1.minutes.ago)
          @user.stub(:lists).and_return([@list])
        end
        it "完了がかえること" do
          @user.process(client).should == [:complete, nil]
        end
      end
      describe "最近取得したもの以外が含まれる場合" do
        before do
          @list = stub_model(List)
          @user.stub(:lists).and_return([@list])
        end
        it "メンバーリストを取得すること" do
          @list.should_receive(:fetch_list_members)
          @user.process(client)
        end
        it "" do
          @list.should_receive(:fetch_list_members).and_return(result = mock('result'))
          @user.process(client).should == [:fetch_list_members, result]
        end
      end
    end
  end
end
