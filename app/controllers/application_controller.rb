class ApplicationController < ActionController::API
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_google_user!

  private
  def authenticate_google_user!
    auth_header = request.headers["Authorization"]
    if auth_header.present? && auth_header.starts_with?("Bearer ")
      id_token = auth_header.split(' ').last
      begin
        payload = Google::Auth::IDTokens.verify_oidc(id_token, aud: ENV["GOOGLE_CLIENT_ID"])
        @current_user_info = payload
      rescue Google::Auth::IDTokens::SignatureError, Google::Auth::IDTokens::ExpiredTokenError => e
        render json: { error: 'Invalid or expired Google ID token' }, status: :unauthorized
      end
    else
      render json: { error: 'Authorization header missing' }, status: :unauthorized
    end
    redirect_to root_path unless current_user.present?
  end
end
