FactoryGirl.define do
  factory :invoice do
    sequence(:id)
    sequence(:ba_id)
    sequence(:number)
    sequence(:issue_date) { |n| Time.now.advance(days: n) }
    sequence(:due_date) { |n| Time.now.advance(days: n) }
    sequence(:client_name) {|n| "Client #{n}" }
    sequence(:total_amount) { |n| n*10000 }
    profile
  end

end
