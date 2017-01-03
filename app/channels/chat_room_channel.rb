class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    reject! unless ChatRoomPolicy.new(current_user, ChatRoom.find(params[:chat_room_id]))
    stream_from "chat_room_#{params[:chat_room_id]}"
  end

  def send_message(data)
    MessageBroadcastJob.perform_later(params[:chat_room_id], data['message'], current_user)
  end
end
