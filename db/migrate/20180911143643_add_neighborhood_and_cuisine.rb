class AddNeighborhoodAndCuisine < ActiveRecord::Migration[5.0]
  def change
    add_column :foodtrucks, :neighborhood, :string
    add_column :foodtrucks, :cuisine, :string
  end
end
