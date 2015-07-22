class Invoice < ActiveRecord::Base
  validates :ba_id, :number, :issue_date, :client_name, :profile,
            :due_date, presence: true
  has_many :lines, dependent: :destroy
  belongs_to :profile

  def total_cost
    self.lines.sum(:cost)
  end

  def balance
    total_amount - total_cost
  end
end
