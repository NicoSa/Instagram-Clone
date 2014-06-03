class OrderMailer < ActionMailer::Base
  default from: "no-reply@pizza-poser.com"

  def successful_order(order)
  	@order = order
  	mail(to: order.user.email, subject: 'Thanks for your order')
  end

  # def problematic_order
  # end

  # def cancelled_order
  # end

end
