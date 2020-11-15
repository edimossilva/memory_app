class CreateMemoriesTags < ActiveRecord::Migration[6.0]
  def change
    create_table :memories_tags do |t|
      t.integer :memory_id, null: false, index: true, foreign_key: true
      t.integer :tag_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
