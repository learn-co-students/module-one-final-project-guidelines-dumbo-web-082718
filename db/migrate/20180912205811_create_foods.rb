class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :price
      t.string :category
      t.integer :foodtruck_id
    end
  end
end
