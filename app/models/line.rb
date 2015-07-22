class Line < ActiveRecord::Base
  belongs_to :invoice

  validates :description, :quantity, :unit_price, :invoice,
            presence: true
end
