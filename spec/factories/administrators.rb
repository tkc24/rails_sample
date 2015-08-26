# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :administrator do
    sequence(:email) { |n| "admin#{n}@example.com"}
    password 'pw'
    suspended false
  end
end
