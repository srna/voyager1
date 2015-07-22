FactoryGirl.define do
  factory :profile do
    sequence(:agenda) { |n| "https://joe#{n}.billapp.cz" }
    sequence(:email) { |n| "joe#{n}@example.com" }
    password         'joesthebest'
    user
  end
end
