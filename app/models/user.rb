class User < ApplicationRecord
  def self.from_token_payload(payload)
    where(auth0_id: payload['sub']).first_or_initialize.tap do |user|
      user.auth0_id = payload['sub']
      user.save!
    end
  end
end
