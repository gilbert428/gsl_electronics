# config/initializers/stripe.rb
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
STRIPE_SUPPORTED_COUNTRIES = ['US', 'CA', 'GB', 'AU', 'NZ'] # Add your supported countries here
