class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :country

      t.timestamps
    end
    add_index :locations, [:name, :country], unique: true
  end
end
