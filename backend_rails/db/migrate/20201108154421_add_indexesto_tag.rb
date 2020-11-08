class AddIndexestoTag < ActiveRecord::Migration[6.0]
  def change
    add_index 'tags', ['user_id', 'name'], unique: true
  end
end
