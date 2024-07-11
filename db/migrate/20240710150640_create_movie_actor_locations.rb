class CreateMovieActorLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_actor_locations do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :actor, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
    add_index :movie_actor_locations, [:movie_id, :actor_id, :location_id], unique: true, name: 'idx_movie_actor_locations_unique'
  end
end
