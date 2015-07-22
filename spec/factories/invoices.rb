FactoryGirl.define do
  factory :invoice do
    sequence(:id)
    sequence(:ba_id)
    sequence(:number)
    sequence(:issue_date) { |n| Time.now.advance(days: n) }
    sequence(:due_date) { |n| Time.now.advance(days: n) }
    sequence(:client_name) {|n| "Client #{n}" }
  end

end
