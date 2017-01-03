class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(room_id, message_text, user)
    msg = ChatRoom.find(room_id).messages.build do |m|
      m.text = message_text
      m.user = user
    end
    return unless msg.save

    ActionCable.server.broadcast "chat_room_#{room_id}",
                                 type: 'new_message',
                                 user_name: user.name,
                                 message: message_text
  end
end
