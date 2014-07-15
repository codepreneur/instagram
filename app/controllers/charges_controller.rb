class ChargesController < ApplicationController
	before_action :authenticate_user!

	def new
    @post = Post.find_by title: params[:post_id]
  end

  def create
    @post = Post.find_by title: params[:post_id]
    # Amount in cents
    @amount = 2000

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => "Print of #{@post.title}",
      :currency    => 'usd'
    )

    Order.create(user: current_user, post: @post)

    flash[:notice] = 'thanks for your payment!'
    redirect_to posts_path
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
