module BillApp
  Invoice = Struct.new(:id, :number, :client, :due_date,
                       :total_amount, :currency, :issue_date, :lines
  )
end
