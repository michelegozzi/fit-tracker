# == Schema Information
#
# Table name: foods
#
#  id                   :integer          not null, primary key
#  food_code            :integer
#  display_name         :string(255)
#  portion_default      :decimal(10, 5)
#  portion_amount       :decimal(10, 5)
#  portion_display_name :string(255)
#  factor               :decimal(10, 5)
#  increment_factor     :decimal(10, 5)
#  multiplier_factor    :decimal(10, 5)
#  grains               :decimal(10, 5)
#  whole_grains         :decimal(10, 5)
#  vegetables           :decimal(10, 5)
#  orange_vegetables    :decimal(10, 5)
#  drkgreen_vegetables  :decimal(10, 5)
#  starchy_vegetables   :decimal(10, 5)
#  other_vegetables     :decimal(10, 5)
#  fruits               :decimal(10, 5)
#  milk                 :decimal(10, 5)
#  meats                :decimal(10, 5)
#  soy                  :decimal(10, 5)
#  drybeans_peas        :decimal(10, 5)
#  oils                 :decimal(10, 5)
#  solid_fats           :decimal(10, 5)
#  added_sugars         :decimal(10, 5)
#  alcohol              :decimal(10, 5)
#  calories             :decimal(10, 5)
#  saturated_fats       :decimal(10, 5)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Food < ActiveRecord::Base
	attr_accessible	:food_code, :display_name, :portion_default, :portion_amount, :portion_display_name, :factor, :increment_factor, :multiplier_factor, :grains, :whole_grains, :vegetables, :orange_vegetables, :drkgreen_vegetables, :starchy_vegetables, :other_vegetables, :fruits, :milk, :meats, :soy, :drybeans_peas, :oils, :solid_fats, :added_sugars, :alcohol, :calories, :saturated_fats

	#def getBinding
	#    return binding()# a method defined in Kernel module
	#end

	def self.all_foods(q)

		find_by_sql("SELECT * FROM (SELECT display_name, portion_display_name, calories FROM foods WHERE display_name LIKE '#{q}' UNION SELECT DISTINCT name display_name, NULL AS portion_display_name, calories FROM meals WHERE name LIKE '#{q}') m ORDER BY display_name")
		#connection.select_all("SELECT display_name, portion_display_name, calories FROM foods WHERE display_name LIKE '#{q}' UNION SELECT DISTINCT name display_name, NULL AS portion_display_name, calories FROM meals WHERE name LIKE '#{q}'")
		
	end
end
