Knock.setup do |config|
  config.token_audience = -> { Rails.application.secrets.auth0_client_id }
  config.token_secret_signature_key = -> { JWT.base64url_decode Rails.application.secrets.auth0_client_secret }
end
