class AddUniqueToUserId < ActiveRecord::Migration[6.0]
  def change
    add_index 'memories', ['user_id', 'key'], unique: true
  end
end
