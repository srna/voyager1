module ApplicationHelper
  def currency(amount, currency)
    number_to_currency(amount, precision: 2, separator: ',', delimiter: ' ',
                       unit: currency, format: '%n %u')
  end

  def number_color(number)
    if number < 0
      "danger"
    elsif number > 0
      "success"
    else
      ""
    end
  end
end
