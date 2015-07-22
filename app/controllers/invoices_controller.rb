require 'bill_app/connection'

class InvoicesController < ApplicationController
  before_filter :check_profile, :connect, :check_profile_validity,
                only: [:new, :import]
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = current_user.profile.invoices
  end

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
                          client_name: ba_invoice.client.company,
                          total_amount: ba_invoice.total_amount,
                          currency: ba_invoice.currency
    )
    invoice.profile = current_user.profile
    ba_invoice.lines.each do |line|
      invoice.lines << Line.new(description: line.description,
                                 quantity: line.quantity,
                                 unit_price: line.unit_price
      )
    end
    if invoice.save
      redirect_to invoice, notice: 'Invoice was successfully imported.'
    else
      redirect_to new_invoice_path, alert: 'Couldn\'t import invoice.'
    end
  end

  def show
  end

  def edit

  end

  def update

  end

  def destroy
    @invoice.destroy
    redirect_to invoices_path, alert: 'Invoice was deleted.'
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

  def set_invoice
    @invoice = current_user.profile.invoices.find(params[:id])
  end
end
