class Invoice < ActiveRecord::Base
  validates :ba_id, :number, :issue_date, :client_name, :profile,
            :due_date, :total_amount, presence: true
  has_many :lines, dependent: :destroy
  belongs_to :profile

  def total_cost
    self.lines.sum(:cost)
  end

  def balance
    (total_amount || 0) - (total_cost || 0)
  end
end
