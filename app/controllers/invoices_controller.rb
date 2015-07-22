require 'bill_app/connection'

class InvoicesController < ApplicationController
  before_filter :check_profile, :connect, :check_profile_validity,
                only: [:new, :import]
  def new
    @invoices = @connection.invoices
    imported_invoices = current_user.profile.invoices
    imported_invoices.each do |ii|
      @invoices.delete ii.ba_id
    end
  end

  def import
    @invoice = @connection.invoice(params[:id].to_i)
  end

  private
  def check_profile
    if current_user.profile.nil?
      redirect_to profile_path,
        alert: 'You have to have a BillApp profile to access invoices.'
    end
  end

  def connect
    @connection = BillApp::Connection.new(current_user.profile)
  end

  def check_profile_validity
    unless @connection.valid?
      redirect_to profile_path,
        alert: 'You have an invalid BillApp profile. Please update it.'
    end
  end
end
