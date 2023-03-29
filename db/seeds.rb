require "open-uri"
require "json"

start = Time.now

puts "=== DESTROYING TABLES ==="

User.destroy_all
puts "Users deleted"

Movie.destroy_all
puts "Movies deleted"

Restaurant.destroy_all
puts "Restaurants deleted"

puts "=== SEEDING TABLES ==="

puts "=== CREATING 3 USERS ==="
user1 = User.create(first_name: "Jan", last_name: "Krejcik", email: "jan-krejcik@outlook.com", password: "password",
  password_confirmation: "password")
puts "- #{user1.first_name}"

user2 = User.create(first_name: "Ronan", last_name: "Boyle", email: "ronanoboyle.rob@gmail.com", password: "password",
  password_confirmation: "password")
puts "- #{user2.first_name}"

user3 = User.create(first_name: "Jaro", last_name: "JagrSidorNovy", email: "jaroslav.sidor.ml@gmail.com", password: "password",
  password_confirmation: "password")
puts "- #{user3.first_name}"

puts "=== CREATING 400 MOVIES ==="

movie_genres = {
  "Action" => 28,
  "Adventure" => 12,
  "Animation" => 16,
  "Comedy" => 35,
  "Crime" => 80,
  "Documentary" => 99,
  "Drama" => 18,
  "Family" => 10751,
  "Fantasy" => 14,
  "History" => 36,
  "Horror" => 27,
  "Music" => 10402,
  "Mystery" => 9648,
  "Romance" => 10749,
  "Science Fiction" => 878,
  "TV Movie" => 10770,
  "Thriller" => 53,
  "War" => 10752,
  "Western" => 37
}

for page in 1..20 do
  # Will later API key in .env file
  url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV.fetch('MOVIE_API')}&language=en-US&page=#{page}"
  movies = URI.open(url).read
  data = JSON.parse(movies)

  data["results"].each do |movie|
    new_movie = Movie.new
    new_movie.title = movie["title"]
    new_movie.overview = movie["overview"]

    # There is option for poster_img as well but backdrop_img is just picture wihout any info (better suited for background img)

    if movie["backdrop_path"].nil?
      new_movie.image = "https://image.tmdb.org/t/p/original" + movie["poster_path"]
    else
      new_movie.image = "https://image.tmdb.org/t/p/original" + movie["backdrop_path"]
    end

    # Each movie has min. 1 genre but in order to store more values we would need extra table so just taking first genre
    genre_id = movie["genre_ids"].first

    # Fetch is looking for a value to a given key (as movies_genres hash has key/value switched I used invert)
    new_movie.genre = movie_genres.invert.fetch(genre_id)

    new_movie.vote_average = movie["vote_average"]
    year = movie["release_date"].match(/\d{4}/)
    new_movie.year = year[0].to_i
    new_movie.save
    puts "#{new_movie.id} - #{new_movie.title}."
  end
end

puts "=== FINISHED IN #{(Time.now - start).round}s ==="
