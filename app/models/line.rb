class Line < ActiveRecord::Base
  belongs_to :invoice

  validates :ba_id, :description, :quantity, :unit_price, presence: true
end
