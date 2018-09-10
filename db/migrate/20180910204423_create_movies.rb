class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.integer :release_year
      t.integer :length_in_minutes
    end
  end
end
