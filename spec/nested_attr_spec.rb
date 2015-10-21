require 'rails_helper'
require 'factory_girl'
#require 'factories'
require 'nested_attr'
require 'active_admin'


RSpec.describe "something" do
  context "one to one" do
    
    it "should have nested attributes" do
      attr = NestedAttr.nested_attr_for(:post)
      expect(attr["user"]["username"]).not_to eq(nil)
    end

  end
  context "many to many" do
    
    context "accept nested attributes" do
      it "should have `_attributes` in it" do
        attr = NestedAttr.nested_attr_for(:post, has_many=[:categories])
        expect(attr["categories_attributes"]).not_to eq(nil)
      end
    end

  end
end

