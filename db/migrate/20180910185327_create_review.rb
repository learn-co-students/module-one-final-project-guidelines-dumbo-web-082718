class CreateReview < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :comment
      t.integer :user_id
      t.integer :foodtruck_id
    end
  end
end
