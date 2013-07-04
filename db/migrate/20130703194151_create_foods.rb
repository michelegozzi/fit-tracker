class CreateFoods < ActiveRecord::Migration
	def change
		create_table :foods do |t|
			t.decimal :food_code, :precision => 10, :scale => 0
			t.string :display_name
			t.decimal :portion_default, :precision => 10, :scale => 5
			t.decimal :portion_amount, :precision => 10, :scale => 5
			t.string :portion_display_name
			t.decimal :factor, :precision => 10, :scale => 5
			t.decimal :increment, :precision => 10, :scale => 5
			t.decimal :multiplier, :precision => 10, :scale => 5
			t.decimal :grains, :precision => 10, :scale => 5
			t.decimal :whole_grains, :precision => 10, :scale => 5
			t.decimal :vegetables, :precision => 10, :scale => 5
			t.decimal :orange_vegetables, :precision => 10, :scale => 5
			t.decimal :drkgreen_vegetables, :precision => 10, :scale => 5
			t.decimal :starchy_vegetables, :precision => 10, :scale => 5
			t.decimal :other_vegetables, :precision => 10, :scale => 5
			t.decimal :fruits, :precision => 10, :scale => 5
			t.decimal :milk, :precision => 10, :scale => 5
			t.decimal :meats, :precision => 10, :scale => 5
			t.decimal :soy, :precision => 10, :scale => 5
			t.decimal :drybeans_peas, :precision => 10, :scale => 5
			t.decimal :oils, :precision => 10, :scale => 5
			t.decimal :solid_fats, :precision => 10, :scale => 5
			t.decimal :added_sugars, :precision => 10, :scale => 5
			t.decimal :alcohol, :precision => 10, :scale => 5
			t.decimal :calories, :precision => 10, :scale => 5
			t.decimal :saturated_fats, :precision => 10, :scale => 5
			t.timestamps
		end
	end
end
