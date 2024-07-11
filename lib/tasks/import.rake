require 'csv'

namespace :import do
  desc "Import movies from CSV files"
  task data: :environment do
    # Import movies
    CSV.foreach('lib/assets/movies.csv', headers: true) do |row|
      movie = Movie.find_or_create_by!(name: row['Movie'], year: row['Year']) do |m|
        m.description = row['Description']
        m.director = row['Director']
      end

      actor = Actor.find_or_create_by!(name: row['Actor'])
      location = Location.find_or_create_by!(name: row['Filming location'], country: row['Country'])

      MovieActorLocation.find_or_create_by!(
        movie: movie,
        actor: actor,
        location: location
      )
    end
    puts "import done"
  end
end