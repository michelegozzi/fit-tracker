class AddIndexToMealsSheetId < ActiveRecord::Migration
  def change
  	add_index :meals, :sheet_id
  	
  end
end
