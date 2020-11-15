class AddIndexTomemoryTag < ActiveRecord::Migration[6.0]
  def change
    add_index 'memory_tags', ['memory_id', 'tag_id'], unique: true
  end
end
