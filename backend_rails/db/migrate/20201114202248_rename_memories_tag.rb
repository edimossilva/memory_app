class RenameMemoriesTag < ActiveRecord::Migration[6.0]
  def change
    rename_table :memories_tags, :memory_tags
  end
end
