class DropTableChatRoomsUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :chat_rooms_users
  end
end
