class Line < ActiveRecord::Base
  belongs_to :invoice

  validates :description, :quantity, :unit_price, :invoice,
            presence: true

  default_scope { order('id') }

  def balance
    unit_price*quantity - (cost || 0)
  end
end
