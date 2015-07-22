FactoryGirl.define do
  factory :line do
    sequence(:description) { |n| "Polozka #{n}" }
    sequence(:quantity) { |n| n*10 }
    sequence(:unit_price) { |n| n*1000 }
    sequence(:cost) { |n| n*800 }
    invoice
  end
end
