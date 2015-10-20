require 'rails_helper'
require 'factory_girl'
#require 'factories'
require 'nested_attr'
require 'active_admin'


RSpec.describe "something" do
  context "one to one" do
    it "should have nested attributes" do
      attr = NestedAttr.nested_attr_for(:post)
      attr["user"]["username"].should_not be_nil
    end
  end
  context "many to many" do
    context "accept nested attributes" do
      it "should have `_attributes` in it" do
        attr = NestedAttr.nested_attr_for(:post)
        attr["categories_attributes"].should_not be_nil
      end
    end
  end

  it "should create post" do
    #post "/admin/posts", post: attr
    #{"utf8"=>"✓", "authenticity_token"=>"M+xCzxrmIVOPAfmh+48ILIaCn2Dg+i1hOOakAtY+MF7LorL/nnWCbHYsv7RoE3P/pK9a9HT4Xuazq5B878ErdQ==", "post"=>{"title"=>"sssa", "body"=>"asas", "categories_attributes"=>{"0"=>{"name"=>"sa"}}}, "commit"=>"Create Post"}

    #attr["category_ids"].should_not be_nil
  end

  it "" do

    #attr = NestedAttr.nested_attr_for(:post,except=[:user])
    #attr.keys.include? "user"
  end
end