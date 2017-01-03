class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :user, presence: true
  validates :chat_room, presence: true

  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
