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

# url = "https://tmdb.lewagon.com/movie/top_rated"

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
  url = "https://api.themoviedb.org/3/movie/top_rated?api_key=06e099a08c65eac6bc1d2e590f767821&language=en-US&page=#{page}"
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

puts "=== CREATING 1 Restaurant ==="

new_restaurant = Restaurant.new
new_restaurant.name = "Can Dende"
new_restaurant.city = "Barcelona"
new_restaurant.address = "C/ de la Ciutat de Granada, 44"
new_restaurant.phone = "930 19 82 97"
new_restaurant.cuisine = "brunch"
new_restaurant.rating = rand(1..5)
# Price can act $$$ signes showed like in google
new_restaurant.price = rand(1..4)

# Images random for now
new_restaurant.image_1 = "https://source.unsplash.com/random?restaurant"
new_restaurant.image_2 = "https://source.unsplash.com/random?restaurant"
new_restaurant.image_3 = "https://source.unsplash.com/random?restaurant"
new_restaurant.save

puts "=== FINISHED IN #{(Time.now - start).round}s ==="
