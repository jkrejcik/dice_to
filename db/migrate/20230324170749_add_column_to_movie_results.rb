class AddColumnToMovieResults < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_results, :accepted, :boolean
  end
end
