class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :movie, null: false, foreign_key: true
      t.string :user, null: false, default: ""
      t.integer :stars, null: false, default: 0
      t.text :review, null: false, default: ""

      t.timestamps
    end
    add_index :reviews, [:movie_id, :user], unique: true
  end
end
