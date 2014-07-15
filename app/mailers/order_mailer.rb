class OrderMailer < ActionMailer::Base
  default from: "no-reply@instagramay.com"

  def confirmation(order)
    @order = order
    mail(to: order.user.email, subject: "You just ordered a print of #{order.post.title}")
  end

  # def cancelled
  # end

  # def status_change
  # end

  # def refunded
  # end
  
end
