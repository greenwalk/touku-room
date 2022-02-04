class CreateFields < ActiveRecord::Migration[6.0]
  def change
    create_table :fields do |t|
      t.integer    :status, default: 0, null: false
      t.references :theme , null: false, foreign_key: true
      t.timestamps
    end
  end
end
