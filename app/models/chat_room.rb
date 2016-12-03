class ChatRoom < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages

  validates :users, presence: true
end
