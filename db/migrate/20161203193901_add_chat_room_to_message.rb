class AddChatRoomToMessage < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :chat_room, foreign_key: true
  end
end
