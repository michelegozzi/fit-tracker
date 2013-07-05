class AddIndexToMealsName < ActiveRecord::Migration
	def change
		add_index :meals, :name
	end
end
