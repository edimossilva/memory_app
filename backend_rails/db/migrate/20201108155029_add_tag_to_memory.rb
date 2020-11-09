class AddTagToMemory < ActiveRecord::Migration[6.0]
  def change
    add_column :memories, :tag_id, :integer, null: true
    add_index  :memories, :tag_id
  end
end
