class CreateHaikus < ActiveRecord::Migration[6.0]
  def change
    create_table :haikus do |t|
      t.string     :content    , null: false                   
      t.string     :content_sub, null: false                   
      t.references :user       , null: false, foreign_key: true
      t.references :field      , null: false, foreign_key: true      
      t.timestamps
    end
  end
end
