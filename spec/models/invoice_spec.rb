require 'rails_helper'

RSpec.describe Invoice, type: :model do
  [:ba_id, :number, :issue_date, :client_name, :profile, :due_date].each do |a|
    it { should validate_presence_of a }
  end

  context "has a method" do
    it "#total_cost that calculates total cost" do
      expect(subject.total_cost).to eql subject.lines.sum(:cost)
    end
    it "#balance that calculates the balance" do
      expect(subject.balance).to eql (subject.total_cost -
                                         (subject.total_amount || 0))
    end
  end

end
