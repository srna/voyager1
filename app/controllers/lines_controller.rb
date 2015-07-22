class LinesController < ApplicationController
  before_action :set_line, only: [:update]
  def update
    if @line.update(line_params)
      redirect_to @invoice, notice: 'Invoice line cost updated.'
    else
      redirect_to @invoice, alert: 'Invalid value.'
    end
  end

  private
  def set_line
    @invoice = current_user.profile.invoices.find(params[:invoice_id])
    @line = @invoice.lines.find(params[:id])
  end

  def line_params
    params.require(:line).permit(:cost)
  end
end
