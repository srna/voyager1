class Invoice < ActiveRecord::Base
  has_many :lines, dependent: :destroy

  validates :ba_id, :number, :issue_date, :client_name, presence: true
end
