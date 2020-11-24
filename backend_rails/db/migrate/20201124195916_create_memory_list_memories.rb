class CreateMemoryListMemories < ActiveRecord::Migration[6.0]
  def change
    create_table :memory_list_memories do |t|
      t.integer :memory_list_id, null: false, index: true, foreign_key: true
      t.integer :memory_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
