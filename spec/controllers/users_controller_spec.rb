require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'when auth token is not provided' do
    it 'returns 401' do
      get :profile
      expect(response.status).to eql(401)
    end
  end

  context 'when auth token is provided' do
    it 'returns json with information about current user' do
      user = create(:user)
      token_payload = { sub: user.auth0_id }.stringify_keys!
      token = Knock::AuthToken.new(payload: token_payload).token

      request.headers['Authorization'] = "Bearer #{token}"
      get :profile

      expect(response.status).to eql(200)
    end
  end
end
