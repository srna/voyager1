module ApplicationHelper
  def currency(amount, currency)
    number_to_currency(amount, precision: 2, separator: ',', delimiter: ' ',
                       unit: currency, format: '%n %u')
  end
end
