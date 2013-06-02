class AddSheetIdToMeals < ActiveRecord::Migration
  def change
  	add_column :meals, :sheet_id, :integer
  end
end
