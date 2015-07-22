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
    ba_invoice = @connection.invoice(params[:id].to_i)
    raise ActiveRecord::RecordNotFound if ba_invoice.nil?
    if Invoice.find_by_ba_id(ba_invoice.id)
      return redirect_to new_invoice_path,
                  alert: 'Invoice is already imported.'
    end
    invoice = Invoice.new(ba_id: ba_invoice.id,
                          number: ba_invoice.number,
                          issue_date: ba_invoice.issue_date,
                          due_date: ba_invoice.due_date,
                          client_name: ba_invoice.client.company
    )
    invoice.profile = current_user.profile
    ba_invoice.lines.each do |line|
      invoice.lines << Line.new(description: line.description,
                                 quantity: line.quantity,
                                 unit_price: line.unit_price
      )
    end
    if(invoice.save)
      redirect_to invoice, notice: 'Invoice was successfully imported.'
    else
      redirect_to new_invoice_path, alert: 'Couldn\'t import invoice.'
    end
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
