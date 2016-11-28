# Set your plaid keys: https://dashboard.plaid.com/account/keys
Plaid.config do |p|
  p.client_id = ENV['PLAID_CLIENT_ID']
  p.secret = ENV['PLAID_SECRET']
  p.env = :tartan
end