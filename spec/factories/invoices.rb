FactoryGirl.define do
  factory :invoice do
    sequence(:id)
    sequence(:ba_id)
    sequence(:number)
    sequence(:issue_date) { |n| Time.now.advance(seconds: n) }
    sequence(:client_name) {|n| "Client #{n}" }
  end

end
