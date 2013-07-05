class AddIndexToFoodsDisplayName < ActiveRecord::Migration
	def change
		add_index :foods, :display_name
	end
end
