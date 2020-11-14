class RemoveTagFromMemories < ActiveRecord::Migration[6.0]
  def change
    remove_column :memories, :tag_id
  end
end
