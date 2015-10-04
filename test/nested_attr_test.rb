require 'test_helper'
require 'factory_girl'
require 'factories'
require 'nested_attr'

class NestedAttrTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, NestedAttr
  end

  def test_one_to_one
  	attr = FactoryGirl.nested_attributes_for(:post)
  	assert_equal attr["user"]["username"], 'sadaf2605'
  end

  def test_many
  	puts attr = FactoryGirl.nested_attributes_for(:user)
  	assert_equal attr["user"]["username"], 'sadaf2605'
  end

end
