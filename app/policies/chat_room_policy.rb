class ChatRoomPolicy
  attr_reader :user, :chat_room

  def initialize(user, chat_room)
    raise Pundit::NotAuthorizedError, 'Must be included in the room' unless chat_room.users.include?(user)
    @user = user
    @chat_room = chat_room
  end
end
