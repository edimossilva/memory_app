class RemoveIndexesFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_index 'memories', ['key']
    remove_index 'memories', ['user_id']
  end
end
