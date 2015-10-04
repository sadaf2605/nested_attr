require 'factory_girl'

FactoryGirl.define do
  factory :user,class: User do
    username "sadaf2605"
  end

  factory :category, class: Category do
  #	name "cat 1"
  	sequence :name do |n|
    	"category#{n}"
  	end
  end

  # This will use the User class (Admin would have been guessed)
  factory :post, class: Post do
    user 
    title "this is a title"
    body "this is a huge body"

   	after :build do |p|
   		p.categories << create(:category)
	end

  end





end