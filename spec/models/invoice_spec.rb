require 'rails_helper'

RSpec.describe Invoice, type: :model do
  [:ba_id, :number, :issue_date, :client_name, :profile, :due_date].each do |a|
    it { should validate_presence_of a }
  end
end
