class PlaidController < ApplicationController
  def new

  end

  def create
    # If a plaid token is submitted, request a bank token
    if params[:public_token] && params[:account_id]
      public_token = params[:public_token]
      account_id = params[:account_id]

      # Get the Stripe bank token from Plaid
      token = Plaid::User.exchange_token(public_token, account_id)

      # Create Stripe customer with token
      begin
        customer = Stripe::Customer.create(
          source: token.stripe_bank_account_token,
          description: 'Plaid example customer',
          metadata: { 'plaid_account' => account_id }
        )

        # Create sessions for the customer and bank account
        session[:customer] = customer.id
        session[:bank_account] = customer.sources.data.first.id

        # Direct the customer to pay
        flash[:success] = 'Your bank account has been connected.'
        redirect_to new_payment_path
      rescue Stripe::RateLimitError => e
        # Too many requests made to the API too quickly
        flash[:alert] = e.message
        render 'create'
      rescue Stripe::InvalidRequestError => e
        # Invalid parameters were supplied to Stripe's API
        flash[:alert] = e.message
        render 'create'
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        flash[:alert] = e.message
        render 'create'
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
        flash[:alert] = e.message
        render 'create'
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        flash[:alert] = e.message
        render 'create'
      rescue => e
        # Something else happened, completely unrelated to Stripe
        flash[:alert] = e.message
        render 'create'
      end
    else
      flash[:alert] = 'No Plaid token provided'
      render 'create'
    end

  end
end
