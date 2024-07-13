require 'rails_helper'
require 'rake'

RSpec.describe 'import:data' do
  before(:all) do
    Rails.application.load_tasks  
    Rake::Task['import:data'].reenable  
  end

  describe 'import_movies' do
    it 'imports movies from CSV' do
      expect { Rake::Task['import:data'].invoke }.to output("begin movies import\nimport movies done\nbegin reviews import\nimport reviews done\n").to_stdout

      expect(Movie.count).to eq(2)
      expect(Movie.first.name).to eq("Gone in 60 seconds")
      expect(Movie.first.description).to eq("A retired master car thief must come back to the industry and steal fifty cars with his crew in one night to save his brother's life.")
      expect(Movie.first.year).to eq(2000)
      expect(Movie.first.director).to eq("Dominic Sena")

      expect(Review.count).to eq(9)  
      expect(Review.last.movie.name).to eq("Inception")
      expect(Review.last.stars).to eq(2)
    end
  end
end
