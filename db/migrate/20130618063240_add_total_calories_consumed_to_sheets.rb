class AddTotalCaloriesConsumedToSheets < ActiveRecord::Migration
	def change
		add_column :sheets, :total_calories_consumed, :integer
	end
end
