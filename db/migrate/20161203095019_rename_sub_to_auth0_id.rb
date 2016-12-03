class RenameSubToAuth0Id < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :sub, :auth0_id
  end
end
