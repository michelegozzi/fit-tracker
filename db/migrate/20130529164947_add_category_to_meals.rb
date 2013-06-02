class AddCategoryToMeals < ActiveRecord::Migration
  def change
  	add_column :meals, :category, :integer
  end
end
