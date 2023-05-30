class ApplicationController < ActionController::API
  before_action :authenticate

  rescue_from JWT::VerificationError, with: :invalid_token
  rescue_from JWT::DecodeError, with: :decode_error

  private

  def authenticate
    authorization_header = request.headers['Authorization']
    decoded_header = JsonWebToken.decode(authorization_header)

    User.find(decoded_header[:user_id])
  end

  def invalid_token
    render json: { invalid_token: 'invalid token' }
  end

  def decode_error
    render json: { decode_error: 'decode error' }
  end
end
