FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "joe#{n}@example.com" }
    password         'joesthebest'
    factory :user_with_profile do
      profile
    end
  end
end
