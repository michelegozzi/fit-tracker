class RenameCalorieTargetForSheets < ActiveRecord::Migration
	def change
		rename_column :sheets, :calories_target, :calorie_target
	end
end
