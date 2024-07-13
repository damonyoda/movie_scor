class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name, null:false, default: ""
      t.text :description, null:false, default: ""
      t.integer :year, null:false
      t.string :director, null:false, default: ""

      t.timestamps
    end
  end
end
