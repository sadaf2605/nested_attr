class Post < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :categories
	has_and_belongs_to_many :tags

	accepts_nested_attributes_for :categories, :allow_destroy => true
#	accepts_nested_attributes_for :tags, :allow_destroy => true
end
