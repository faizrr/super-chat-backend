class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chat_room_#{message.chat_room.id}",
                                 type: 'new_message',
                                 user_name: message.user.name,
                                 message: message.text
  end
end
