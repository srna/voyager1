class Invoice < ActiveRecord::Base
  validates :ba_id, :number, :issue_date, :client_name, presence: true
  has_many :lines, dependent: :destroy
  belongs_to :profile
end
