class MigrateChatRoomsUsers < ActiveRecord::Migration[5.0]
  def change
    User.transaction do
      User.find_each do |user|
        user.chat_rooms = user.deprecated_chat_rooms
      end
    end
  end
end
