class RemoveContentSubToHaikus < ActiveRecord::Migration[6.0]
  def change
    remove_column :haikus, :content_sub, :string
  end
end
