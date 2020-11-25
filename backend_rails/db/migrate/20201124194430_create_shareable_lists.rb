class CreateShareableLists < ActiveRecord::Migration[6.0]
  def change
    create_table :shareable_lists do |t|
      t.string :name, null: false
      t.integer :user_id, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
