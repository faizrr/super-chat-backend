require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'Foobar', auth0_id: 'test')
    expect(user).to be_valid
  end

  it 'is invalid if auth0_id is not provided' do
    user = User.new(name: 'Foobar')
    expect(user).to_not be_valid
  end

  describe 'from_token_payload' do
    it 'creates new user if there\'re no users with such auth0_id' do
      new_user_attrs = attributes_for(:user)

      stub_request(:post, Rails.application.secrets.auth0_url + '/tokeninfo').
        to_return(body: { name: new_user_attrs[:name], user_id: new_user_attrs[:auth0_id] }.to_json)

      payload = { sub: new_user_attrs[:auth0_id] }
      user = User.from_token_payload(payload)

      expect(User.find_by(auth0_id: new_user_attrs[:auth0_id])).to eql(user)
    end

    it 'returns user with such auth0_id' do
      user = create(:user)
      payload = { sub: user.auth0_id }.stringify_keys!
      user_from_payload = User.from_token_payload(payload)

      expect(user_from_payload).to eql(user)
    end
  end
end
