class AddPublicToShareableList < ActiveRecord::Migration[6.0]
  def change
    add_column 'shareable_lists', 'public', :boolean, default: false
  end
end
