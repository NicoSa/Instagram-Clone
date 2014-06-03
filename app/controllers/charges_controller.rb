class ChargesController < ApplicationController

	def new
	end

	def create
		@amount = 500

		customer = Stripe::Customer.create(
			:email => 'EMAIL PLACEHOLDER',
			:card => params[:stripeToken]
		)

		charge = Stripe::Charge.create(
			:customer => customer.id,
			:amount => @amount,
			:description => 'Rails Stripe customer',
			:currency => 'gbp'
		)
	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to charges_path
	end

end
