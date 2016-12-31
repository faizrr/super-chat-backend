class CreateUserChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :user_chat_rooms do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :chat_room, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
