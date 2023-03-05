require "open-uri"

start = Time.now

puts "=== DESTROYING TABLES ==="

User.destroy_all
puts "Users deleted"

Movie.destroy_all
puts "Movies deleted"

puts "=== SEEDING TABLES ==="

puts "=== CREATING USERS ==="
user1 = User.create(first_name: "Jan", last_name: "Krejcik", email: "jan-krejcik@outlook.com", password: "password",
  password_confirmation: "password")
puts "- #{user1.first_name}"

user2 = User.create(first_name: "Ronan", last_name: "Boyle", email: "ronanoboyle.rob@gmail.com", password: "password",
  password_confirmation: "password")
puts "- #{user2.first_name}"

user3 = User.create(first_name: "Jaro", last_name: "Sidor", email: "jaroslav.sidor.ml@gmail.com", password: "password",
  password_confirmation: "password")
puts "- #{user3.first_name}"

puts "=== CREATING MOVIES ==="
