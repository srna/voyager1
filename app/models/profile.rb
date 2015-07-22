require 'bill_app/connection'

class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :invoices, dependent: :destroy

  validates :agenda, presence: true
  validates :email, presence: true, email: true
  validates :password, presence: true

  validate :agenda_exists

  validates :user, presence: true

  private
  def agenda_exists
    bac = BillApp::Connection.new(self)
    unless bac.valid?
      errors.add(:agenda, 'Could not log in to agenda')
    end
  end
end
