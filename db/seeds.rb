require "open-uri"
require "json"

start = Time.now

puts "=== DESTROYING TABLES ==="

User.destroy_all
puts "Users deleted"

Movie.destroy_all
puts "Movies deleted"

puts "=== SEEDING TABLES ==="

puts "=== CREATING 3 USERS ==="
user1 = User.create(first_name: "Jan", last_name: "Krejcik", email: "jan-krejcik@outlook.com", password: "password",
  password_confirmation: "password")
puts "- #{user1.first_name}"

user2 = User.create(first_name: "Ronan", last_name: "Boyle", email: "ronanoboyle.rob@gmail.com", password: "password",
  password_confirmation: "password")
puts "- #{user2.first_name}"

user3 = User.create(first_name: "Jaro", last_name: "Sidor", email: "jaroslav.sidor.ml@gmail.com", password: "password",
  password_confirmation: "password")
puts "- #{user3.first_name}"

puts "=== CREATING 20 MOVIES ==="

# Scraping Top 20 movies to db

url = "https://tmdb.lewagon.com/movie/top_rated"
movies = URI.open(url).read
data = JSON.parse(movies)

movie_genres = ["Action", "Adventure", "Animation", "Comedy", "Crime", "Drama", "Family", "Horror"]

data["results"].each do |movie|
  new_movie = Movie.new
  new_movie.title = movie["title"]
  new_movie.overview = movie["overview"]
  new_movie.image = "https://image.tmdb.org/t/p/original" + movie["poster_path"]
  new_movie.genre = movie_genres.sample
  year = movie["release_date"].match(/\d{4}/)
  new_movie.year = year[0].to_i
  new_movie.save
  puts "#{new_movie.id} - #{new_movie.title}."
end

puts "=== FINISHED IN #{(Time.now - start).round}s ==="
