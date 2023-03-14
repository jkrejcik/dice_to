class AddVoteAverageToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :vote_average, :float
  end
end
