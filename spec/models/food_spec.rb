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

require 'spec_helper'

describe Food do
  pending "add some examples to (or delete) #{__FILE__}"
end
