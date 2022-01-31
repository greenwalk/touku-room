class CreateThemes < ActiveRecord::Migration[6.0]
  def change
    create_table :themes do |t|
      t.integer :season_id, null:false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
