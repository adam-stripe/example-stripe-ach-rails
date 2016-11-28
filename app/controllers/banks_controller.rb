class BanksController < ApplicationController
  def new
  end

  def create
    # Check for a bank token
    if params[:stripeToken]
      token = params[:stripeToken]

      # Create Stripe customer with token
      begin
        # If there's not a customer object for the current user, create one
        if session[:customer].nil?
          customer = Stripe::Customer.create(
            source: token,
            description: 'Bank account form example customer'
          )

        # Replace the existing bank account for the existing customer
        else
          customer = Stripe::Customer.retrieve(session[:customer])
          customer.source = token
          customer.save
        end

        # Create a session for the customer and bank account ID
        session[:customer] = customer.id
        session[:bank_account] = customer.sources.data.first.id

        # Redirect to verify microdeposit amounts
        flash[:success] = 'Your bank account has been connected.'
        redirect_to new_microdeposit_path
      rescue Stripe::RateLimitError => e
        # Too many requests made to the API too quickly
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue Stripe::InvalidRequestError => e
        # Invalid parameters were supplied to Stripe's API
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue => e
        # Something else happened, completely unrelated to Stripe
        flash[:alert] = e.message
        redirect_to new_banks_path
      end
    else
      flash[:alert] = 'No stripeToken provided'
      redirect_to new_banks_path
    end
  end
end
