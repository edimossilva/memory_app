class RemoveIndexesFromTag < ActiveRecord::Migration[6.0]
  def change
    remove_index 'tags', ['user_id']
  end
end
