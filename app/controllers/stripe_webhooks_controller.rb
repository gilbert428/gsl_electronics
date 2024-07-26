# app/controllers/stripe_webhooks_controller.rb
class StripeWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def event
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      render json: { message: 'Invalid payload' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      render json: { message: 'Invalid signature' }, status: 400
      return
    end

    case event['type']
    when 'checkout.session.completed'
      session = event['data']['object']
      handle_checkout_session(session)
    end

    render json: { message: 'success' }
  end

  private

  def handle_checkout_session(session)
    # Find the cart by the session ID and update the order status
    cart = Cart.find_by(secret_id: session['client_reference_id'])
    if cart
      cart.update(status: 'completed')
      # You can also create an Order record here
    end
  end
end
