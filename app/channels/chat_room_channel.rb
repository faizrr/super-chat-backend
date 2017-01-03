class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    reject! unless ChatRoomPolicy.new(current_user, ChatRoom.find(params[:chat_room_id]))
    stream_from "chat_room_#{params[:chat_room_id]}"
  end

  def send_message(data)
    msg = ChatRoom.find(params[:chat_room_id]).messages.build do |m|
      m.text = data['message']
      m.user = current_user
    end

    return unless msg.save
    serialized = ActiveModelSerializers::SerializableResource.new(msg).as_json
    ActionCable.server.broadcast "chat_room_#{params[:chat_room_id]}", serialized
  end
end
