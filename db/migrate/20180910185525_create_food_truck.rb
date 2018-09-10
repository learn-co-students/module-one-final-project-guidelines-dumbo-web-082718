class CreateFoodTruck < ActiveRecord::Migration[5.0]
  def change
    create_table :foodtrucks do |t|
      t.string :name
    end
  end
end
