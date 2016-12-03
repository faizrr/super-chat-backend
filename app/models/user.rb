class User < ApplicationRecord
  def self.from_token_payload(payload)
    @jwt_payload = payload

    where(auth0_id: payload['sub']).first_or_initialize.tap do |user|
      profile = get_profile_info

      user.auth0_id = profile['user_id']
      user.name = profile['name']

      user.save!
    end
  end

  private

  def self.get_profile_info
    jwt = Knock::AuthToken.new(payload: @jwt_payload).token

    url = Rails.application.secrets.auth0_url + '/tokeninfo'
    res = RestClient.post(url, { id_token: jwt }.to_json, headers={ 'content-type': 'application/json' })

    JSON.parse(res.body)
  end
end
