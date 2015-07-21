FactoryGirl.define do
  factory :profiles do
    sequence(:agenda) { |n| "https://joe#{n}.billapp.cz" }
    sequence(:email) { |n| "joe#{n}@example.com" }
    password         'joesthebest'
  end
end
