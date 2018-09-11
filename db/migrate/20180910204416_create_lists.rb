class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :list_name
      t.integer :user_id
      t.integer :movie_id
    end
  end
end
