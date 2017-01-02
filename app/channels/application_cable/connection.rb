module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      auth_token = request.params[:auth_token]
      user = nil
      if auth_token.present?
        payload = Knock::AuthToken.new(token: auth_token).payload
        user = User.find_by(auth0_id: payload['sub'])
      end
      user || reject_unauthorized_connection
    end
  end
end
