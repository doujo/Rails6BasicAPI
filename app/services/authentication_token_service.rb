class AuthenticationTokenService
  HMAC_SECRET = "waluh$123"
  ALGORITHM_TYPE = "HS256"

  def self.call
    payload = { "username" => "tes123"}

    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end
end
