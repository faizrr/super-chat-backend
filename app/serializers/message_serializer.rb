class MessageSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :text, :created_at
  has_one :user, serializer: MessageUserSerializer
end
