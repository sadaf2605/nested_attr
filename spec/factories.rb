require 'factory_girl'

FactoryGirl.define do
  factory :admin_user, :class => AdminUser do
    sequence(:email){|n| "email#{n}@example.com"}
    password "password"
    password_confirmation "password"
  end

  factory :category, class: Category do
  #	name "cat 1"
  	sequence :name do |n|
    	"category#{n}"
  	end
  end
  factory :user, class: User do
    username "sadaf2605"
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