class CreateHaikus < ActiveRecord::Migration[6.0]
  def change
    create_table :haikus do |t|




      
      t.timestamps
    end
  end
end
