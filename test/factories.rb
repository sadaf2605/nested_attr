require 'factory_girl'

FactoryGirl.define do
  factory :user,class: User do
    username "sadaf2605"
  end

  # This will use the User class (Admin would have been guessed)
  factory :post, class: Post do
    user 
    title "this is a title"
    body "this is a huge body"
  end
end