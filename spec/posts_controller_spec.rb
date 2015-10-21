include Devise::TestHelpers

RSpec.describe Admin::PostsController, :type => :controller do
  before(:each) do
    @user = FactoryGirl.create(:admin_user)
    sign_in @user
  end

  describe "Create" do
    it "creates post" do
      expect{post :create, post: NestedAttr.nested_attr_for(:post, has_many=[:tags])}.to change{Post.count}.by(1)
    end
  end
end