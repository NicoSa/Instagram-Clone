class ChargesController < ApplicationController

	def new
		@post = Post.find(params[:post_id])
	end

	def create
		@post = Post.find(params[:post_id])
		@amount = 2000

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

		Order.create(user: current_user, post: @post)
		flash[:notice] = "Thanks for your order"
		redirect_to('/posts')

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to post_charges_path(@post)
	end

end
