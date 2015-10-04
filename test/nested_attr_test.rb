require 'test_helper'
require 'factory_girl'
require 'factories'
require 'nested_attr'

class NestedAttrTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, NestedAttr
  end

  def test_one_to_one
  	attr = NestedAttr.nested_attr_for(:post)
  	assert_not_nil attr["user"]["username"]
  end

  def test_many_to_many
  	attr = NestedAttr.nested_attr_for(:post)
  	assert_not_nil attr["category_ids"]
  end

  def test_except
  	puts attr = NestedAttr.nested_attr_for(:post,except=[:user])
  	assert_not attr.keys.include? "user"
  end

end
