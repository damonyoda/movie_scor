require 'csv'

namespace :import do
  desc "Import movies from CSV files"

  task data: :environment do
    ActiveRecord::Base.transaction do
      movie_cache = import_movies
      import_reviews(movie_cache)
    end
  end

  def import_movies
    puts "begin movies import"
    movies_data = []
    movies_cache = {}
    actors_cache = {}
    locations_cache = {}
    CSV.foreach('lib/assets/movies.csv', headers: true) do |row|
      movie = movies_cache[row['Movie']] ||= Movie.find_or_create_by!(name: row['Movie'], year: row['Year']) do |m|
        m.description = row['Description']
        m.director = row['Director']
      end

      actor = actors_cache[row['Actor']] ||= Actor.find_or_create_by!(name: row['Actor'])

      location_key = "#{row['Filming location']},#{row['Country']}"
      location = locations_cache[location_key] ||= Location.find_or_create_by!(
        name: row['Filming location'],
        country: row['Country']
      )

      movies_data << {
        movie_id: movie.id,
        actor_id: actor.id,
        location_id: location.id
      }
    end
    MovieActorLocation.import movies_data, validate: false
    puts "import movies done"
    return movies_cache
  rescue StandardError => e
    puts "Error importing movies: #{e.message}"
  end

  def import_reviews(movies_cache)
    puts "begin reviews import"
    reviews_data = []
    CSV.foreach('lib/assets/reviews.csv', headers: true) do |row|
      movie = movies_cache[row['Movie']]
      if movie
        reviews_data << Review.new(
          movie: movie,
          user: row['User'],
          stars: row['Stars'],
          review: row['Review']
        )
      else
        puts "movie not found: #{row['Movie']}"
      end
    end
    Review.import reviews_data
    puts "import reviews done"
  rescue StandardError => e
    puts "Error importing reviews: #{e.message}"
  end

end