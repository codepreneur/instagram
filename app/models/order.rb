class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :post


  def number
    date_section = created_at.strftime('%d%m%y')
    number_section = "%04d" % id 

    date_section + number_section
  end
  
end
