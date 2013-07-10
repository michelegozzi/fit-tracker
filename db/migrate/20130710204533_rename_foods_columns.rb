class RenameFoodsColumns < ActiveRecord::Migration
	def change
		rename_column :foods, :increment, :increment_factor
		rename_column :foods, :multiplier, :multiplier_factor
		
	end
end
