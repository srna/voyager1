require 'rails_helper'

RSpec.describe Line, type: :model do
  [:description, :quantity, :unit_price, :invoice].each do |a|
    it { should validate_presence_of a }
  end
end
