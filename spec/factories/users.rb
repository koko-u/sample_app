# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "name"
    email "name@example.com"
    password "PassW0rd"
    password_confirmation "PassW0rd"
    remember_token nil
  end
end
