class AddTimeTakenColumnToMovieResults < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_results, :time_taken, :integer
  end
end
