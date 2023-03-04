class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.string :genre
      t.integer :year
      t.text :overview
      t.string :image

      t.timestamps
    end
  end
end
