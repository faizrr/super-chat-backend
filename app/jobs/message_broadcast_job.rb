class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(room_id, message_text, user)
    @room_id = room_id
    @message_text = message_text
    @user = user

    return unless save_message
    ActionCable.server.broadcast "chat_room_#{room_id}", render_message
  end

  private

  def save_message
    @message = ChatRoom.find(@room_id).messages.build do |m|
      m.text = @message_text
      m.user = @user
    end
    @message.save
  end

  def render_message
    MessageSerializer.new(@message).to_json
  end
end
